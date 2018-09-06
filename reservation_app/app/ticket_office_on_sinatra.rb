
# Deploy as a web service using Sinatra
# before you'll be able to run this you'll need 'gem install sinatra'

require 'sinatra'
require 'byebug'

require_relative './lib/ticket_office'

get '/' do
  'Hello World'
end

post '/reserve' do
  # office = TicketOffice.new()
  # office.make_reservation(request.body)

  { train_id: 'Express_2000', seats: ['1A'], booking_reference: 'booking_123'}.to_json
end

configure do
  set :port, '8083'
end