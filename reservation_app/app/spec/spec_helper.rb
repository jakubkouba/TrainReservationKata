require 'webmock/rspec'

Dir["#{File.expand_path('../lib', File.dirname(File.absolute_path(__FILE__)))}/**/*.rb"].each { |file| require file }