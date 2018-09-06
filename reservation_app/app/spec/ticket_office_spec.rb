require 'spec_helper'

describe TicketOffice do

  describe 'make reservation for one ticket in empty train' do
    ticket_office = TicketOffice.new
    request =

    it 'returns request' do
      expect(ticket_office.make_reservation(request)).to eq 'request string'
    end
  end

  describe 'train is empty' do
    describe 'and passenger reserves one ticket' do
      let(:train) { Train.new }

      before { allow(train).to receive(:empty?).and_return(true) }

      it 'reserves one seat' do
        reservation = train.reserve_seats(1)

        expect(reservation).to eq(['ticket123', '1A'])
      end
    end
  end
end
