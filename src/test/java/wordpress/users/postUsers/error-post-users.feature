Feature: (users - postUsers) Error post users

  Background:

    * def generate = callonce read('classpath:wordpress/users/utility/generate-users-request.feature')
    * copy request_body = generate.request_body
    * def create_user = callonce read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status: 201}

    * configure afterScenario = function(){ karate.call('classpath:wordpress/users/utility/delete-users.feature', {id: create_user.response.id, status:200, params:{force:1, reassign:1 }}); }

    Given url site
    And path 'users'

  @users
  Scenario Outline: (users - postUsers) internal server error post users

    * request_body.username = <username>
    * request_body.password = <password>
    * request_body.email = <email>

    Given request request_body
    When method post
    Then status <status>
    And match response == read('classpath:data/schemas/error/response/internal_server_error.json')

    Examples:
      | username              | password              | email              | status|
      | request_body.username | request_body.password | request_body.email | 500   |
      | "lorem sum"           | request_body.password | request_body.email | 500   |


  @users
  Scenario Outline: (users - postUsers) bad request error post users

    * request_body.username = <username>
    * request_body.password = <password>
    * request_body.email = <email>

    Given request request_body
    When method post
    Then status <status>
    And match response == read('classpath:data/schemas/error/response/bad_request.json')

    Examples:
      | username              | password              | email              | status|
      | null                  | request_body.password | request_body.email | 400   |
      | request_body.username | null                  | request_body.email | 400   |


  @users
  Scenario Outline: (users - postUsers) invalid mail error post users

    * request_body.username = <username>
    * request_body.password = <password>
    * request_body.email = <email>


    Given request request_body
    When method post
    Then status <status>
    And match response == read('classpath:data/schemas/error/response/bad_request_with_validations.json')
    
    * print read('classpath:data/schemas/error/response/bad_request_with_validations.json')

    Examples:
      | username              | password              | email        | status|
      | request_body.username | request_body.password | "lorem sum"  | 400   |
      | request_body.username | request_body.password | "null"       | 400   |



   