Feature: (backofficeUtility - utility) Create resource asynchronous

  # Source file in firefly-api-test-backoffice-shared-resources

  # param: data_retry (Object) optional
  # param: params (Object)
  # param: request_body (Object)

  @ignore
  Scenario: (backofficeUtility - utility) Create resource asynchronous
    * if (karate.get('data_retry') === null) data_retry = { count: 5, interval: 1000 }
    * configure retry = data_retry

    * url params.url
    * path params.path
    * request request_body
    * method post
    * status 201
    * def id = response.id

    # Validation
    * def get_resource = call read('classpath:utility/get-resource-by-id.feature') {data_retry: '#(data_retry)', params: '#(params)', id: '#(id)', status_retry: '200'}