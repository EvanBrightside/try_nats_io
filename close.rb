# frozen_string_literal: true

require './connect'

# Close connection
$nc.close
puts 'Disconnected from nats ...'
