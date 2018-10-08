require 'reservations'
require 'byebug'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    seat_list = train_data_service.train(train_id)

    free_seats = seat_list.select { |_, seat| free_seat?(seat) }

    seats_to_reserve = free_seats.keys.first(seats)

    reserved_seats = seat_list.count - seats_to_reserve.count
    filled = (reserved_seats / seat_list.count.to_f) * 100
    raise OverbookedException if filled >= 70

    train_data_service.reserve(train_id, seats_to_reserve, booking_reference_service.reservation_number)
    Reservation.new(train_id, seats_to_reserve)
  end

  private

  def free_seat?(seat_property)
    seat_property['booking_reference'].empty?
  end
end

class OverbookedException < StandardError; end

