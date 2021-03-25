Feature: (users - utility) Delete users by id

  # param: id (String)
  # param: status (int)
  # param: params (object)

  Background:
    * configure retry = { count: 5, interval: 1000 }

  @ignore
  Scenario: (users - utility) Delete users by id
    Given url site
    And path 'users', id
    And params params
    When method delete
    Then assert responseStatus == status


