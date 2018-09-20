require 'reservations'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    train = train_data_service.find_train(train_id)
    reserved_seats = train.reserve_seats(seats, booking_reference_service.reservation_number)
    Reservation.new(train_id, reserved_seats)
  end
end


