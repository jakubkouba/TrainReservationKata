require 'reservations'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    trains         = train_data_service.trains(train_id)
    train          = trains[train_id]
    reserved_seats = []

    train['seats'].each do |seat_number, seat_attributes|
      if seat_attributes['booking_reference'].empty?
        reserved_seats << seat_number
      end
    end

    train_data_service.reserve(train_id, reserved_seats.first(seats), booking_reference_service.reservation_number)

    Reservation.new(train_id, reserved_seats.first(seats))
  end
end


