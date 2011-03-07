//
//  ECSessionTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"

@interface ECSessionTestCase : GHAsyncTestCase { }
@end

@implementation ECSessionTestCase

- (void) setUp {
	[[ECSession sharedSession] forgetCredentials];
}

- (void) tearDown {
	[[ECSession sharedSession] forgetCredentials];
}

- (void) testAuthenticationWhileNotRememberingUser {
	[self prepare];
	
	ECSession *session = [ECSession sharedSession];
	GHAssertFalse([session hasUnexpiredAccessToken], @"Expected session to be unauthenticated at this point");
	[session authenticateWithClientId:@"30bb1d4f-2677-45d1-be13-339174404402"
						 clientString:@"ctstate"
							 username:@"veronicastudent3"
							 password:@"veronicastudent3"
					 keepUserLoggedIn:NO
							 delegate:self
							 callback:@selector(sessionDidAuthenticateWhileNotRememberingUser)];
	
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) sessionDidAuthenticateWhileNotRememberingUser {
	ECSession *session = [ECSession sharedSession];
	GHAssertTrue([session hasUnexpiredAccessToken], @"Expected accessToken to be set after authentication");
	GHAssertFalse([session hasUnexpiredGrantToken], @"Expected grantToken not to be set after authentication while not remembering user");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testAuthenticationWhileNotRememberingUser)];
}

- (void) testAuthenticationWhileRememberingUser {
	[self prepare];
	
	ECSession *session = [ECSession sharedSession];
	GHAssertFalse([session hasUnexpiredAccessToken], @"Expected session to be unauthenticated at this point");
	GHAssertFalse([session hasUnexpiredGrantToken], @"Expected session to be without a grant token at this point");
	[session authenticateWithClientId:@"30bb1d4f-2677-45d1-be13-339174404402"
						 clientString:@"ctstate"
							 username:@"veronicastudent3"
							 password:@"veronicastudent3"
					 keepUserLoggedIn:YES
							 delegate:self
							 callback:@selector(sessionDidAuthenticateWhileRememberingUser)];
	
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) sessionDidAuthenticateWhileRememberingUser {
	ECSession *session = [ECSession sharedSession];
	GHAssertTrue([session hasUnexpiredAccessToken], @"Expected accessToken to be set after authentication");
	GHAssertTrue([session hasUnexpiredGrantToken], @"Expected grantToken to be set after authentication while remembering user");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testAuthenticationWhileRememberingUser)];
}

@end
