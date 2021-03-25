Feature: (users - utility) Stop testing if service unavailable

  @ignore
  Scenario: (users - utility) Stop testing if service unavailable
    * url users
    * header Content-Type = 'application/json'
    * header X-B3-TraceId = randomHex
    * header X-B3-SpanID = randomHexSpan
    * method options
    * assert responseStatus != 503