//
//  ECSessionTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"

@interface ECSessionTestCase : GHAsyncTestCase<ECSessionAuthenticationDelegate> { }
@end

@implementation ECSessionTestCase

- (void) tearDownClass {
	[[ECSession sharedSession] forgetCredentials];
}

- (void) testAuthentication {
	[self prepare];
	
	ECSession *session = [ECSession sharedSession];
	session.authenticationDelegate = self;
	GHAssertFalse(session.isAuthenticated, @"Expected session to be unauthenticated at this point");
	[session authenticateWithClientId:@"30bb1d4f-2677-45d1-be13-339174404402"
						 clientString:@"sandbox"
							 username:@"manderson"
							 password:@"manderson"];

	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) sessionDidAuthenticate:(ECSession *)aSession {
	ECSession *session = [ECSession sharedSession];
	GHAssertEqualObjects(session, aSession, @"Unexpected session reference sent to delegate method");
	GHAssertNotNil(session.accessToken, @"Expected accessToken to be set after authentication");
	GHAssertTrue(session.isAuthenticated, @"Expected session to be authenticated after authentication");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testAuthentication)];
}

@end
