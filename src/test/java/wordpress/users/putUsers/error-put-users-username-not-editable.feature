Feature: (users - putUsers) Error put username is not editable

 
  @users
  Scenario: (users - putUsers) Error put users

    * def generate = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate.request_body
    * def expected_response = read('classpath:wordpress/users/data/schemas/response/users.json')

    * def create_user = call read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status: 201}
    * match create_user.response == expected_response
    * def userId = create_user.response.id


    Given url site
    And path 'users', userId
    And request
    """
      {
      'username':'Loren Ipsum 22',
      'first_name':'Lorem',
      'last_name':'Ipsum',

      }
    """
    When method put
    Then status 400

    And match response == read('classpath:data/schemas/error/response/rest_user_invalid_argument.json')

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') { id: '#(userId)', status:200, params:{force:1, reassign:1}}
    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')



    