Feature: (users - getUsersById) Get users by id

  @gold
  @users
  Scenario: (users - getUsersById) Get users by id

    * def generate_request = callonce read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate_request.request_body
    * def expected_response = read('classpath:wordpress/users/data/schemas/response/users.json')

    * def create_user = callonce read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status:201 }
    * match create_user.response == expected_response

    Given url site
    And path 'users', create_user.response.id
    When method get
    Then status 200
    And match response == read('classpath:wordpress/users/data/schemas/response/get_user.json')


    * def delete_user = callonce read('classpath:wordpress/users/utility/delete-users.feature') { id: '#(create_user.response.id)', status:200, params:{force:1, reassign:1 }}

    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')
