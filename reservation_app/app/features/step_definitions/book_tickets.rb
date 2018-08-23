Given(/^Empty train$/) do
  # mock empty train
end

When(/^Customer reserves seat (\d+)A in train Express_(\d+) with booking reference booking(\d+)$/) do |seat, train, booking_reference|
  @payload = { train_id: train, seats: [seat], booking_reference: booking_reference }
end



Then(/^System reserves one seat$/) do
  post 'http://localhost:8083/reserve', @payload
  json = JSON.parse(last_response.body).with_indifferent_access
  expect(json[:seats]).to eq ['1A']
end