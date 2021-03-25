Feature: (users - getUsers) Get users

  @gold
  @users
  Scenario Outline: (users - getUsers) Get users

    Given url site
    And params {per_page: <per_page>, orderby: <orderby>, order: <order> }
    And path 'users'
    When method get
    Then status 200
    * def count = response.length
    And match count == <count_user>

    Examples:
    | per_page | count_user | orderby         | order |
    | 2        | 2          | registered_date | desc  |
    | 11       | 11         | email           | asc   |

