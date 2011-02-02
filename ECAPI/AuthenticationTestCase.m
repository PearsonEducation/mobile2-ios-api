//
//  LogInTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"

@interface AuthenticationTestCase : GHAsyncTestCase<ECSessionAuthenticationDelegate> {
	ECSession *session;
}
@end

@implementation AuthenticationTestCase

- (void) dealloc {
	[session release];
}

- (void) testAuthentication {
	[self prepare];
	
	session = [[ECSession alloc] initWithClientString:@"sandbox" username:@"manderson" password:@"manderson"];
	session.authenticationDelegate = self;
	[session authenticate];

	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) sessionDidAuthenticate:(ECSession *)aSession {
	GHAssertNotNil(aSession.accessToken, @"Expected accessToken to be set after authentication");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testAuthentication)];
}

@end
