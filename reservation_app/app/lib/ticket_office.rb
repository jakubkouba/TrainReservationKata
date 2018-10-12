require 'reservations'
require 'byebug'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  MAX_PCT_CAPACITY_ALLOWANCE = 70

  def make_reservation(train_id:, seats:)
    seat_list = train_data_service.train(train_id)

    if reserved_seats_in_pct(seat_list) < MAX_PCT_CAPACITY_ALLOWANCE
      free_seats = seat_list.select { |_, seat| free_seat?(seat) }
      seats_to_reserve = free_seats.keys.first(seats)
      train_data_service.reserve(train_id, seats_to_reserve, booking_reference_service.reservation_number)
    else
      seats_to_reserve = []
    end

    Reservation.new(train_id, seats_to_reserve)
  end

  private

  def reserved_seats_in_pct(seat_list)
    booked_seats = seat_list.reject { |_, seat| free_seat?(seat) }
    (booked_seats.count / seat_list.count.to_f) * 100
  end

  def free_seat?(seat_property)
    seat_property['booking_reference'].empty?
  end
end

class OverbookedException < StandardError; end

