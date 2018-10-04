require 'reservations'
require 'byebug'

class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service        = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    trains = train_data_service.trains

    free_seats = trains[train_id]['seats'].select do |_, seat_property|
      seat_property['booking_reference'].empty?
    end

    reserved_seats = free_seats.keys.first(seats)
    Reservation.new(train_id, reserved_seats)
  end
end


