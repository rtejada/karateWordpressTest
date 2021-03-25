Feature: (users - utility) Delete users by name

  # param: users_name (String)

  @ignore
  Scenario: (users - utility) Delete users by name
    * call read('classpath:wordpress/users/utility/delete-users.feature')