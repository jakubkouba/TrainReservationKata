require 'reservations'
require 'byebug'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  MAX_PCT_CAPACITY_ALLOWANCE = 70

  def make_reservation(train_id:, number_of_seats_to_reserve:)
    seats = train_data_service.train(train_id)

    if reserved_seats_in_pct(seats, number_of_seats_to_reserve) < MAX_PCT_CAPACITY_ALLOWANCE
      free_seats = seats.select { |_, seat| free_seat?(seat) }
      if free_seats.map { |_, seat| seat['coach'] }.uniq.count == 1
        seats_to_reserve = free_seats.keys.first(number_of_seats_to_reserve)
      else
        # search other coach
        free_coach = free_seats.values.last['coach']
        free_seats = seats.select do |_, seat|
          seat['coach'] == free_coach && free_seat?(seat)
        end
        seats_to_reserve = free_seats.keys.first(number_of_seats_to_reserve)
      end
      train_data_service.reserve(train_id, seats_to_reserve, booking_reference_service.reservation_number)
    else
      seats_to_reserve = []
    end

    Reservation.new(train_id, seats_to_reserve)
  end

  private

  def reserved_seats_in_pct(seat_list, number_of_seats_to_reserve)
    booked_seats = seat_list.reject { |_, seat| free_seat?(seat) }
    ((booked_seats.count + number_of_seats_to_reserve) / seat_list.count.to_f) * 100
  end

  def free_seat?(seat_property)
    seat_property['booking_reference'].empty?
  end
end

class OverbookedException < StandardError; end

