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
    train = train_data_service.train(train_id)
    return Reservation.new(train_id, []) unless train.able_to_reserve_seats?(number_of_seats_to_reserve)

    free_seats = train.free_seats

    unless seats_in_one_coach?(free_seats)
      free_coach = next_free_coach(free_seats)
      free_seats = train.select do |seat|
        seat.coach == free_coach && seat.free?
      end
    end

    # seats_to_reserve = free_seats.keys.first(number_of_seats_to_reserve)
    seats_to_reserve = free_seats.first(number_of_seats_to_reserve).map(&:label)

    train_data_service.reserve(train_id, seats_to_reserve, booking_reference_service.reservation_number)
    Reservation.new(train_id, seats_to_reserve)
  end

  private

  def able_to_reserve_seats?(number_of_seats_to_reserve, seats)
    reserved_seats_in_pct(seats, number_of_seats_to_reserve) < MAX_PCT_CAPACITY_ALLOWANCE
  end

  def next_free_coach(free_seats)
    free_seats.last.coach
  end

  def seats_in_one_coach?(free_seats)
    free_seats.map(&:coach).uniq.count == 1
  end

  def reserved_seats_in_pct(seats, number_of_seats_to_reserve)
    booked_seats = seats.reject(&:free?)
    ((booked_seats.count + number_of_seats_to_reserve) / seats.count.to_f) * 100
  end
end

class OverbookedException < StandardError; end

