Feature: Book tickets
  Scenario: Passenger wants to book a single ticket on empty train
    Given Empty train
    When Customer reserves seat 1A in train Express_2000 with booking reference booking_123
    Then System reserves one seat

  Scenario: Passenger wants to book a two tickets on empty train
    Given Empty train
    When When Customer reserves seat 1A and 2A in train Express_2000 with booking reference booking_456
    Then System reserves two seats

