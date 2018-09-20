require 'spec_helper'

describe TicketOffice do

  describe 'Reserve one seat in empty train' do

    it 'reserves a seat' do
      train_id = 'Express_2000'
      seats = 1

      train_data_service = double('TrainDataService')
      booking_reference_service = double('BookingReferenceNumber')
      reservation_number = 15678
      train = double('Train')

      allow(train_data_service).to receive(:find_train).with(train_id).and_return(train)
      allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)
      allow(train).to receive(:reserve_seats).with(seats, reservation_number).and_return(%w[1A])
      allow(train_data_service).to receive(:reserve).with(%w[1A])

      ticket_office = TicketOffice.new(train_data_service, booking_reference_service)

      reservation = ticket_office.make_reservation(train_id: train_id, seats: seats)

      expect(reservation).to have_attributes(seats: %w[1A], train_id: 'Express_2000')
    end
  end

  describe 'Reserve two seats in empty train' do

    it 'reserves 1A and 2A seats' do
      train_id = 'Express_2000'
      seats = 2

      train_data_service = double('TrainDataService')
      booking_reference_service = double('BookingReferenceNumber')
      reservation_number = 15678
      train = double('Train')

      allow(train_data_service).to receive(:find_train).with(train_id).and_return(train)
      allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)
      allow(train).to receive(:reserve_seats).with(seats, reservation_number).and_return(%w[1A 2A])

      ticket_office = TicketOffice.new(train_data_service, booking_reference_service)

      reservation = ticket_office.make_reservation(train_id: train_id, seats: seats)

      expect(reservation).to have_attributes(seats: %w[1A 2A], train_id: 'Express_2000')
    end
  end
end
