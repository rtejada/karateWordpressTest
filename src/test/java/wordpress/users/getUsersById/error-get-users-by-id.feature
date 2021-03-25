Feature: (users - getUsersById) Error get users by id

  @users
  Scenario: (users - getUsersById) Error get users by id

    * def userId = 100000

    Given url site
    And path 'users', userId
    When method get
    Then status 404
    And match response == read('classpath:data/schemas/error/response/not_found.json')


