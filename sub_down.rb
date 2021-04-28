# frozen_string_literal: true

require './connect'

# SubDown
class SubDown < Connect
  nc = Connect.nats_server
  sub_first = nc.subscribe('foo', start_at: :first) do |msg|
    begin
      msg.request
      puts "Received a message (seq=#{msg.seq}): #{msg.data}"
    rescue StandardError
      puts 'I refuse to fail or be stopped!'
    end
  end

  sub_second = nc.subscribe('foo', start_at: :first) do |msg|
    puts "Received a message (seq=#{msg.seq}): #{msg.data}"
  end

  5.times do
    nc.publish('foo', 'hello')
  end

  sub_first.unsubscribe
  sub_second.unsubscribe

  nc.close
end
