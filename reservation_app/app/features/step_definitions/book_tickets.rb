Given(/^Empty train$/) do
  # mock empty train
end
When(/^Customer reserves seat 1A in train Express_2000 with booking reference booking_123$/) do
  @payload = { train_id: 'Express_2000', seats: ['1A'] }
end

Then(/^System reserves one seat$/) do
  post 'http://localhost:8083/reserve', @payload
  expect(json_response).to include(train_id: 'Express_2000', seats: ['1A'])
  expect(json_response).to include(:booking_reference)
end

When(/^When Customer reserves seat 1A and 2A in train Express_2000 with booking reference booking_456$/) do
  @payload = { train_id: 'Express_2000', seats: ['1A', '2A'], booking_reference: 'booking_456' }
end

Then(/^System reserves two seats$/) do
  post 'http://localhost:8083/reserve', @payload
  expect(json_response).to include( train_id: 'Express_2000', seats: ['1A', '2A'])
  expect(json_response).to include(:booking_reference)
end