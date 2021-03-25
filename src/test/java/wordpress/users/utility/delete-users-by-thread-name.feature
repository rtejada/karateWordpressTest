Feature: (users - utility) Delete users by thread name

  @ignore
  Scenario: (users - utility) Delete users by thread name
    * def thread_name = call read('classpath:wordpress/users/utility/get-thread-name.feature')
    * def users_name = thread_name.users_name
    * call read('classpath:wordpress/users/utility/delete-users-by-name.feature') {users_name: '#(users_name)'}