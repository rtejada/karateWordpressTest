Feature: (users - putUsers) Error put users with empty fields

  Background:

    * def generate = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * copy request_body = generate.request_body
    * def create_user = call read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status: 201 }

    * configure afterScenario = function(){ karate.call('classpath:wordpress/users/utility/delete-users.feature', {id: create_user.response.id, status:200, params:{force:1, reassign:1 }}); }


  @users
  Scenario Outline: (users - putUsers) Error put users with empty fields

    Given url site
    And path 'users', create_user.response.id
    And request { <field>: <value>}
    When method put
    Then status 400
    And match response.code contains <invalidParam>

    Examples:
      | field       | value | invalidParam         |
      | name        | {}    | "rest_invalid_param" |
      | first_name  | {}    | "rest_invalid_param" |
      | last_name   | {}    | "rest_invalid_param" |
      | email       | {}    | "rest_invalid_param" |
      | url         | {}    | "rest_invalid_param" |
      | description | {}    | "rest_invalid_param" |
      | locale      | {}    | "rest_invalid_param" |
      | nickname    | {}    | "rest_invalid_param" |
      | slug        | {}    | "rest_invalid_param" |
      | password    | {}    | "rest_invalid_param" |

