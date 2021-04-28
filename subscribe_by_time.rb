# frozen_string_literal: true

require './connect'

# SubDown
class SubscribeByTime < Connect
  nc = Connect.nats_server
  5.times do
    nc.publish('foo', 'old message')
  end
  sleep 20
  # Subscribe starting at a specific time by giving a unix timestamp
  # with an optional nanoseconds fraction
  sub_first = nc.subscribe('foo', start_at: :time, time: Time.now.to_f - 3600) do |msg|
    puts "Received a message (start_at: :time, seq: #{msg.seq}): #{msg.data}"
  end

  sub_first.unsubscribe
  nc.close
end
