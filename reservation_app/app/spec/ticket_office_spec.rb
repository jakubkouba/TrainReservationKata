require_relative '../ticket_office.rb'

describe TicketOffice do

  describe '#make_reservation' do
    ticket_office = TicketOffice.new
    request = 'request string'

    it 'returns request' do
      expect(ticket_office.make_reservation(request)).to eq 'request string'
    end
  end
end
