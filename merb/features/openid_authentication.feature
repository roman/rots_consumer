Feature: openid authentication
  To access to a site
  A user
  Does authenticate using OpenID

  Scenario: The user authenticates successfully with a valid OpenID credential for the first time
    When I go to /
    And I fill in "openid_url" with "http://localhost:1123/john.doe?openid.success=true"
		And I press "Go"
		Then I should receive a response from the OpenID Server
    And I should see "New user from OpenID"

	Scenario: The user cancels the OpenID authentication
		When I go to /
	  And I fill in "openid_url" with "http://localhost:1123/john.doe"
	  And I press "Go"
	  Then I should receive a response from the OpenID Server
	  And I should see "OpenID rejected our request"

	Scenario: The user provides an invalid identity url
	  When I go to /
		And I fill in "openid_url" with "http://google.com"
	  And I press "Go"
	  And I should see "The OpenID verification failed"
