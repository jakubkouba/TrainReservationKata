require File.join(File.dirname(__FILE__), '../../ticket_office_on_sinatra.rb')

require 'rspec'
require 'active_support/all'
require 'rack/test'

class TicketOffice
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end

World { TicketOffice.new }