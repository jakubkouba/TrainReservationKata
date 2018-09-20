class TicketOffice

  attr_reader :train_data_service, :booking_reference_service

  def initialize(train_data_service, booking_reference_service)
    @train_data_service = train_data_service
    @booking_reference_service = booking_reference_service
  end

  def make_reservation(train_id:, seats:)
    train = train_data_service.find_train(train_id)
    reserved_seats = train.reserve_seats(seats, booking_reference_service.reservation_number)
    Reservation.new(reserved_seats, train_id)
  end
end

class Reservation

  attr_reader :seats, :train_id

  def initialize(seats, train_id)
    @seats = seats
    @train_id = train_id
  end

end


