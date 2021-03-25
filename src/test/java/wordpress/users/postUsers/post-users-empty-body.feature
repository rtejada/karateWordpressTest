Feature: (users - postUsers) Post users with empty optional and required fields

  @users
  Scenario: (users - postUsers) Post users with all empty field

    Given url site
    And path 'users'
    And request { }
    When method post
    Then status 400
    And match response == read('classpath:data/schemas/error/response/bad_request.json')

  @users
  Scenario: (users - postUsers) Post users with empty required field

    Given url site
    And path 'users'
    And request
    """
    {
        "first_name": "Cathe",
        "last_name": "Ross",
        "description": "Description of the user"
    }
    """
    When method post
    Then status 400
    And match response == read('classpath:data/schemas/error/response/bad_request.json')
