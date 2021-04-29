# frozen_string_literal: true

require 'nats/client'
require 'fiber'

NATS.start(servers:["nats://127.0.0.1:4222"]) do |nc|
  nc.subscribe('time') do |_, reply|
    nc.publish(reply, 'response')
  end

  Fiber.new do
    # Use the response
    msg = nc.request('time', '')
    puts msg
    puts "Reply: #{msg}"
  end.resume
end
