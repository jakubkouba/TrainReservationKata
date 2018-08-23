Feature: Book tickets
  Scenario: Passenger wants to book a single ticket on empty train
    Given Empty train
    When Customer reserves seat 1A in train Express_2000 with booking reference booking123
    Then System reserves one seat
