Feature: (users - postUsers) Post users

  @gold
  @users
  Scenario: (users - postUsers) Post users

    * def generate_request = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate_request.request_body
    * def expected_response = read('classpath:wordpress/users/data/schemas/response/users.json')

    Given url site
    And path 'users'
    And request request_body
    When method post
    Then status 201
    And match response == expected_response
    * def userId = response.id

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') { id: '#(userId)', status:200, params:{force:1, reassign:1}}

    * def get_user = call read('classpath:wordpress/users/utility/get-users.feature') { id: '#(userId)', status:404}
    * match get_user.response == read('classpath:data/schemas/error/response/not_found.json')


