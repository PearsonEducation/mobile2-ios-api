//
//  LogInTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "AuthenticationTestCase.h"
#import "ECSession.h"

@implementation AuthenticationTestCase

- (void) dealloc {
	[session release]; session = nil;
}

- (void) testAuthentication {
	// we need to run this test on the main thread:
	[self performSelectorOnMainThread:@selector(runAuthenticationTest) withObject:nil waitUntilDone:YES];
}

- (void) runAuthenticationTest {
	authenticationTestCompleted = NO;
	session = [[ECSession alloc] initWithClientString:@"sandbox" username:@"manderson" password:@"manderson"];
	session.authenticationDelegate = self;
	[session authenticate];
	// Wait a few seconds
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
	GHAssertTrue(authenticationTestCompleted, @"Authentication test did not complete");
}

- (void) sessionDidAuthenticate:(ECSession *)aSession {
	authenticationTestCompleted = YES;
	GHAssertEqualObjects(session, aSession, @"Session Test Failure: unexpected session returned to delegate");
	GHAssertNotNil(session.accessToken, @"Expected accessToken to be set after authentication");
}

@end
