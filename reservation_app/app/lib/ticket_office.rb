require 'reservations'
require 'byebug'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    trains = train_data_service.train(train_id)

    free_seats = trains.select { |_, seat| free_seat?(seat) }

    reserved_seats = free_seats.keys.first(seats)
    train_data_service.reserve(train_id, reserved_seats, booking_reference_service.reservation_number)

    Reservation.new(train_id, reserved_seats)
  end

  private

  def free_seat?(seat_property)
    seat_property['booking_reference'].empty?
  end
end


