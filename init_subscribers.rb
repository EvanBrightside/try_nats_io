# frozen_string_literal: true

require './connect'

# Init subscribers
class InitSubscribers < Connect
  Connect.nats_server do |nc|
    2.times do
      nc.subscribe('foo', start_at: :first) do |msg|
        puts "Received a message (seq=#{msg.seq}): #{msg.data}"
      end
    end

    nc.subscribe('bar', start_at: :first) do |msg|
      puts "Received a message (seq=#{msg.seq}): #{msg.data}"
    end
  end
  puts '3 subscribers inited'
end
