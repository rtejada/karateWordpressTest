Feature: (users - deleteUsers) Error delete users without required fields

  Background: preconditions

    * def generate_request = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * def request_body = generate_request.request_body

    * def create_user = call read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status:201 }
    * def userId = create_user.response.id

    Given url site
    And path 'users', userId


  @users
  @debug
  Scenario: (users - deleteUsers) Error delete users without first required param


    Given params {reassign:1 }
    When method delete
    Then status 501
    And match response == read('classpath:data/schemas/error/response/not_implemented.json')

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') {id:'#(userId)', status:200, params:{force:1, reassign:1 }}
    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')

  @users
  Scenario: (users - deleteUsers) Error delete users without second required param

    Given params { force:1 }
    When method delete
    Then status 400
    And match response == read('classpath:data/schemas/error/response/bad_request.json')

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') {id:'#(userId)', status:200, params:{force:1, reassign:1 }}
    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')


  @users
  Scenario: (users - deleteUsers) Error delete users without required param

    Given params { }
    When method delete
    Then status 400
    And match response == read('classpath:data/schemas/error/response/bad_request.json')

    * def delete_user = call read('classpath:wordpress/users/utility/delete-users.feature') {id:'#(userId)', status:200, params:{force:1, reassign:1 }}
    * match delete_user.response == read('classpath:wordpress/users/data/schemas/response/delete-users.json')






