require 'spec_helper'

def free_seat(coach: 'A', seat_number: '1')
  { 'coach' => coach, 'seat_number' => seat_number, 'booking_reference' => "" }
end

describe TicketOffice do
  let(:train_data_service) { double('TrainDataService') }
  let(:booking_reference_service) { double('BookingReferenceNumber') }
  let(:trains) do
    {
      'express_2000' => {
        'seats' => { '1A' => free_seat(coach: 'A', seat_number: '1') }
      }
    }
  end
  
  let(:reservation_number) { '' }
  let(:train_id) { 'express_2000' }
  let(:seats) { 1 }

  let(:ticket_office) { TicketOffice.new(train_data_service, booking_reference_service) }
  subject(:reservation) { ticket_office.make_reservation(train_id: train_id, seats: seats) }

  before do
    allow(train_data_service).to receive(:trains).and_return(trains)
    allow(train_data_service).to receive(:reserve)
    allow(booking_reference_service).to receive(:reservation_number).and_return(reservation_number)
  end

  describe 'Reserve one seat in train' do
    let(:train_id) { 'express_2000' }
    let(:seats) { 1 }
    let(:reservation_number) { '15678' }
    let(:trains) do
      {
        'express_2000' => {
          'seats' => {
            '1A' => free_seat(coach: 'A', seat_number: '1'),
            '2A' => free_seat(coach: 'A', seat_number: '2'),
            '3A' => free_seat(coach: 'A', seat_number: '3')
          }
        }
      }
    end


    it 'reserves seat 1A' do
      expect(reservation).to have_attributes(seats: %w[1A], train_id: 'express_2000')
    end
  end

  describe 'Reserve two seats in train' do
    let(:train_id) { 'express_2000' }
    let(:seats) { 2 }
    let(:reservation_number) { '15678' }
    let(:trains) do
      {
        'express_2000' => {
          'seats' => {
            '1A' => free_seat(coach: 'A', seat_number: '1'),
            '2A' => free_seat(coach: 'A', seat_number: '2'),
            '3A' => free_seat(coach: 'A', seat_number: '3')
          }
        }
      }
    end


    it 'reserves seats 1A and 2A' do
      expect(reservation).to have_attributes(seats: %w[1A 2A], train_id: 'express_2000')
    end
  end

  it 'send reservation to train data service' do
    expect(train_data_service).to receive(:reserve).with(train_id, %w[1A], reservation_number)
    reservation
  end
end
