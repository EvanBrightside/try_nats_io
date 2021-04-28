# frozen_string_literal: true

require './connect'
require 'pry'
# Acknowledgements
class Acknowledgements < Connect
  nc = Connect.nats_server
  5.times do
    nc.publish('foo', 'hello') do |guid, _|
      puts "Received ack with guid=#{guid}"
    end
  end

  # Subscribe with manual ack mode, and set AckWait to 60 seconds
  sub_opts = {
    deliver_all_available: true,
    ack_wait: 60, # seconds
    manual_acks: true
  }
  subscriber = nc.subscribe('foo', sub_opts) do |msg|
    puts "Received a message (seq=#{msg.seq}): #{msg.data}, acking..."
    nc.ack(msg)
  end

  subscriber.unsubscribe
  nc.close
end
