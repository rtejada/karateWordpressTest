Feature: (users - utility) Generate users request

  @ignore
  Scenario: (users - utility) Generate users request
    * def default_user = read('classpath:wordpress/users/data/users.json')

    * def setDefaultValue =
      """
        function(key) {
          if (users[key] == null) {
            users[key] = default_user[key];
          }

          if (key == 'username') {
              users[key] = users[key] + Math.random();
          }

          if (key == 'email') {
              users[key] = Math.random() + users[key];
          }
        }
      """

    * if (karate.get('users') == null) karate.set('users', default_user)
    * karate.forEach(karate.keysOf(default_user), setDefaultValue)

    * def request_path = 'users'
    * def request_body = read('classpath:wordpress/users/data/schemas/request/' + request_path + '.json')

