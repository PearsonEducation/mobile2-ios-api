//
//  TestCaseWithAuthentication.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TestCaseWithAuthentication.h"

@implementation TestCaseWithAuthentication

- (void) setUpClass {
	[self prepare];
	
	ECSession *session = [ECSession sharedSession];
	GHAssertFalse([session hasActiveAccessToken], @"Expected session to be unauthenticated at this point");
	[session authenticateWithClientId:@"30bb1d4f-2677-45d1-be13-339174404402"
						 clientString:@"ctstate"
							 username:@"veronicastudent3"
							 password:@"veronicastudent3"
					 keepUserLoggedIn:NO
							 delegate:self
							 callback:@selector(sessionDidAuthenticate:)];
	
	[self waitForTimeout:3.0];
}

- (void) tearDownClass {
	[[ECSession sharedSession] forgetCredentials];
}

- (void) setUp {
	GHAssertTrue([[ECSession sharedSession] hasActiveAccessToken], @"Expected session to be authenticated");
}

- (void) sessionDidAuthenticate:(ECSession *)aSession {
	// required by ECSessionAuthenticationDelegate protocol
}

@end
