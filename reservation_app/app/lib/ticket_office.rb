require 'reservations'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    reserved_seats = ['1A']
    Reservation.new(train_id, reserved_seats)
  end
end


