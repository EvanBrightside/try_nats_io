# frozen_string_literal: true

require 'stan/client'
# Connection to NATS
class Connect
  def self.nats_server
    @nats_server ||= STAN::Client.new
  end

  opts = { servers: ['nats://127.0.0.1:4222'] }
  nats_server.connect('test-cluster', 'client-123', nats: opts)
  puts 'Connected to nats ...'
end
