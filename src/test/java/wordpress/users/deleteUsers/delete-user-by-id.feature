Feature: (users - deleteUsers) Delete users

  @gold
  @users
    @debug
  Scenario: (users - deleteUsers) Delete users

    * def generate_request = callonce read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate_request.request_body
    * def create_user = callonce read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status:201 }
    
    * print 'ROXANA *************'+ create_user.response

    Given url site
    And path 'users', create_user.response.id
    And params {force:1, reassign:1 }
    When method delete
    Then status 200
    And match response.deleted == true
    * def userId = response.previous.id


    * def delete_user = call read('classpath:wordpress/users/utility/get-users.feature') { id: '#(userId)', status:404}
    * match delete_user.response == read('classpath:data/schemas/error/response/not_found.json')







