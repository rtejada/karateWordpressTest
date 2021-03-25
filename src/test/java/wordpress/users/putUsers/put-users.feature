Feature: (users - putUsers) Put users

  Background: preconditions

    * def generate = call read('classpath:wordpress/users/utility/generate-users-request.feature')
    * copy request_body = generate.request_body
    * def create_user = call read('classpath:wordpress/users/utility/create-users.feature') { request_body: '#(request_body)', status: 201}

    * configure afterScenario = function(){ karate.call('classpath:wordpress/users/utility/delete-users.feature', {id: create_user.response.id, status:200, params:{force:1, reassign:1 }}); }


  @gold
  @users

  Scenario: (users - putUsers) Put users

    * def username = create_user.response.username
    * def name = create_user.response.name

    Given url site
    And path 'users', create_user.response.id
    And request
    """
    {
        "name": "Ms Carey",
        "first_name": "Owen",
        "last_name": "kind",
        "url" : "www.carey.com",
        "description" : "Description of the user"
    }
    """
    When method put
    Then status 200
    And match response.username == username
    And match response.name != name


    * def get_user = call read('classpath:wordpress/users/utility/get-users.feature') { id: '#(create_user.response.id)', status:200}

    * match get_user.response.id == create_user.response.id
    * match get_user.response.name == "Ms Carey"
    * match get_user.response.url ==  "http://www.carey.com"







