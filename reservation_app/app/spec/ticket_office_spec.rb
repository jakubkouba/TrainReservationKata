require 'spec_helper'

describe TicketOffice do

  describe 'Reserve one seat in train' do
    let(:train_data_service) { double('TrainDataService') }
    let(:booking_reference_service) { double('BookingReferenceNumber') }
    let(:train_id) { 'express_2000' }
    let(:seats) { 1 }
    let(:reservation_number) { '15678' }
    let(:trains) do
      {
        'express_2000' => {
          'seats' => {
            '1A' => { 'coach' => 'A', 'seat_number' => '1', 'booking_reference' => "" },
            '2A' => { 'coach' => 'A', 'seat_number' => '2', 'booking_reference' => "" },
            '3A' => { 'coach' => 'A', 'seat_number' => '3', 'booking_reference' => "" },
            '1B' => { 'coach' => 'B', 'seat_number' => '1', 'booking_reference' => "" },
            '2B' => { 'coach' => 'B', 'seat_number' => '2', 'booking_reference' => "" }
          }
        }
      }
    end

    let(:ticket_office) { TicketOffice.new(train_data_service, booking_reference_service) }
    subject(:reservation) { ticket_office.make_reservation(train_id: train_id, seats: seats) }

    it 'reserves seat 1A' do
      allow(train_data_service).to receive(:trains).and_return(trains)
      allow(train_data_service).to receive(:reserve)
      allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)

      expect(reservation).to have_attributes(seats: %w[1A], train_id: 'express_2000')
    end
  end

  describe 'Reserve two seats in train' do
    let(:train_id) { 'express_2000' }
    let(:seats) { 2 }
    let(:train_data_service) { double('TrainDataService') }
    let(:booking_reference_service) { double('BookingReferenceNumber') }
    let(:reservation_number) { '15678' }
    let(:trains) do
      {
        'express_2000' => {
          'seats' => {
            '1A' => { 'coach' => 'A', 'seat_number' => '1', 'booking_reference' => "" },
            '2A' => { 'coach' => 'A', 'seat_number' => '2', 'booking_reference' => "" },
            '3A' => { 'coach' => 'A', 'seat_number' => '3', 'booking_reference' => "" },
            '1B' => { 'coach' => 'B', 'seat_number' => '1', 'booking_reference' => "" },
            '2B' => { 'coach' => 'B', 'seat_number' => '2', 'booking_reference' => "" }
          }
        }
      }
    end

    let(:ticket_office) { TicketOffice.new(train_data_service, booking_reference_service) }
    subject(:reservation) { ticket_office.make_reservation(train_id: train_id, seats: seats) }

    it 'reserves seats 1A and 2A' do
      allow(train_data_service).to receive(:trains).and_return(trains)
      allow(train_data_service).to receive(:reserve)
      allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)
      
      expect(reservation).to have_attributes(seats: %w[1A 2A], train_id: 'express_2000')
    end
  end

  it 'send reservation to train data service' do
    train_id = 'express_2000'
    seats = 2

    train_data_service = double('TrainDataService')
    booking_reference_service = double('BookingReferenceNumber')
    reservation_number = '15678'

    trains = {
      'express_2000' => {
        'seats' => {
          '1A' => { 'coach' => 'A', 'seat_number' => '1', 'booking_reference' => "" },
          '2A' => { 'coach' => 'A', 'seat_number' => '2', 'booking_reference' => "" },
          '3A' => { 'coach' => 'A', 'seat_number' => '3', 'booking_reference' => "" },
          '1B' => { 'coach' => 'B', 'seat_number' => '1', 'booking_reference' => "" },
          '2B' => { 'coach' => 'B', 'seat_number' => '2', 'booking_reference' => "" }
        }
      }
    }

    allow(train_data_service).to receive(:trains).and_return(trains)
    allow(train_data_service).to receive(:reserve)
    allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)

    ticket_office = TicketOffice.new(train_data_service, booking_reference_service)

    expect(train_data_service).to receive(:reserve).with(train_id, %w[1A 2A], reservation_number)

    reservation = ticket_office.make_reservation(train_id: train_id, seats: seats)

    expect(reservation).to have_attributes(seats: %w[1A 2A], train_id: 'express_2000')
  end
end
