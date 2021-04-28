# frozen_string_literal: true

require './connect'
require 'fiber'

# Init subscribers
class RequestReply < Connect
  Connect.nats_server.subscribe('time') do |_, reply|
    Connect.nats_server.publish(reply, 'response')
  end

  Fiber.new do
    # Use the response
    msg = Connect.nats_server.request('time', '')
    puts "Reply: #{msg}"
  end.resume
end
