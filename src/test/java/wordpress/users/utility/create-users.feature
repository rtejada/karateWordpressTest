Feature: (users - utility) Create users

  # param: request_body (Object)
  # param: status (int)

  Background:
    * configure retry = { count: 5, interval: 1000 }

  @ignore
  Scenario: (users - utility) Create users

    Given url site
    And path 'users'
    And request request_body
    When method post
    Then assert responseStatus == status
    


