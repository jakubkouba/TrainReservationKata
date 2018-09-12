Given(/^Empty train$/) do
  # mock empty train
end
When(/^Customer reserves one seat in train Express_2000 with booking reference booking_123$/) do
  @payload = { train_id: 'Express_2000', seats: 1 }
end

Then(/^System reserves one seat$/) do
  post 'http://localhost:8083/reserve', @payload
  expect(json_response).to include(train_id: 'Express_2000', seats: ['1A'])
  expect(json_response).to include(:booking_reference)
end

When(/^When Customer reserves two seats in train Express_2000 with booking reference booking_456$/) do
  @payload = { train_id: 'Express_2000', seats: 2, booking_reference: 'booking_456' }
end

Then(/^System reserves two seats$/) do
  post 'http://localhost:8083/reserve', @payload
  expect(json_response).to include( train_id: 'Express_2000', seats: ['1A', '2A'])
  expect(json_response).to include(:booking_reference)
end