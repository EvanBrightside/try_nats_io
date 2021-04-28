# frozen_string_literal: true

require 'stan/client'

opts = { servers: ['nats://127.0.0.1:4222'] }

sc1 = STAN::Client.new
sc1.connect('test-cluster', 'client-1', nats: opts)

sc2 = STAN::Client.new
sc2.connect('test-cluster', 'client-2', nats: opts)

sc3 = STAN::Client.new
sc3.connect('test-cluster', 'client-3', nats: opts)

group = [sc1, sc2, sc3]

group.each do |sc|
  # Subscribe to queue group named 'bar'
  sc.subscribe('foo', queue: 'bar', durable_name: 'durable_queue') do |msg|
    puts "[#{sc.client_id}] Received a message on durable queue subscription   (seq: #{msg.seq}): #{msg.data}"
  end

  # Notice that you can have a regular subscriber on that subject
  sc.subscribe('foo', durable_name: 'durable_regular') do |msg|
    puts "[#{sc.client_id}] Received a message on durable regular subscription (seq: #{msg.seq}): #{msg.data}"
  end
end

# Clients receives message sequence 1-40 on regular subscription and
# messages become balanced too on the queue group subscription
1.upto(40) { |n| sc2.publish('foo', "hello-#{n}") }

# When the last member leaves the group, that queue group is removed
group.each(&:close)
