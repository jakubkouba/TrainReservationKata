require 'spec_helper'

describe TicketOffice do

  describe 'Reserve one seat in empty train' do

    it 'reserves 1A seat' do
      train_id = 'Express_2000'
      ticket_office = TicketOffice.new
      seats = 1

      reserved_seats = ticket_office.make_reservation(train_id: train_id, seats: seats)
      expect(reserved_seats).to eq(['1A'])
    end
  end
end
