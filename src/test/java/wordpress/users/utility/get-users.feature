Feature: (users - utility) Get users by id

  # param: id (String)
  # param: status (int)

  @ignore
  Scenario: (users - utility) Get users by id
    Given url site
    And path 'users', id
    When method get
    Then assert responseStatus == status