Feature: (users - deleteUsers) Error delete users

  @users
  @debug
  Scenario: (users - deleteUsers) Error delete users

    * def generate_request = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate_request.request_body
    * def create_user = call read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status:201 }
    * def userId = create_user.response.id   

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') {id: '#(userId)', status:200, params:{force:1, reassign:1 }}
    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')
   

    Given url site
    And path 'users', userId
    And params {force:1, reassign:1 }
    When method delete
    Then status 404
    And match response == read('classpath:data/schemas/error/response/not_found.json')
