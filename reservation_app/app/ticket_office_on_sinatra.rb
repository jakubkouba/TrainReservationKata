
# Deploy as a web service using Sinatra
# before you'll be able to run this you'll need 'gem install sinatra'

require 'sinatra'
require 'json'
require 'byebug'
require 'securerandom'

require_relative './lib/ticket_office'

get '/' do
  'Hello World'
end

post '/reserve' do
  # office = TicketOffice.new
  # booked_seats = office.make_reservation(train_id: params[:train_id], seats: params[:seats])

  seats = JSON.parse(File.read('./data/trains.json')).with_indifferent_access
  booked_seats = []
  seats[params[:train_id].downcase][:seats].each do |seat_number, seat_properties|
    if params[:seats].include? seat_number.to_s
      seat_properties[:booking_reference] = params[:booking_reference]
      booked_seats << seat_number
    end
  end

  { train_id: params[:train_id], seats: booked_seats, booking_reference: BookingReferenceNumber.generate }.to_json
end

configure do
  set :port, '8083'
end

class BookingReferenceNumber
  def self.generate
    SecureRandom.uuid
  end
end