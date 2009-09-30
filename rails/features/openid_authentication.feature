Feature: openid authentication
  To access to a site
  A user
  Does authenticate using OpenID

  Scenario: The user authenticates successfully with a valid OpenID credential for the first time
    When I go to the login page
    And I fill in "identity_url" with "http://localhost:1123/john.doe?openid.success=true"
		And I press "Go"
		Then I should receive a response from the OpenID Server
    And I should see "The user was not found, create a new one"

	Scenario: The user cancels the OpenID authentication
		When I go to the login page
	  And I fill in "identity_url" with "http://localhost:1123/john.doe"
	  And I press "Go"
	  Then I should receive a response from the OpenID Server
	  And I should see "OpenID verification was canceled"

	Scenario: The user provides an invalid identity url
	  When I go to the login page
		And I fill in "identity_url" with "http://google.com"
	  And I press "Go"
	  And I should see "Sorry, the OpenID server couldn't be found"
