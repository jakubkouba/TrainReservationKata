Feature: Book tickets

  @book_one_seat
  Scenario: Passenger wants to book a single ticket on empty train
    Given Empty train
    When Customer reserves one seat in train Express_2000 with booking reference booking_123
    Then System reserves one seat

  @book_two_seats
  Scenario: Passenger wants to book a two tickets on empty train
    Given Empty train
    When When Customer reserves two seats in train Express_2000 with booking reference booking_456
    Then System reserves two seats

