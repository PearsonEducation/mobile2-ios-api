//
//  UserTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TestCaseWithAuthentication.h"
#import "User.h"
#import "UserFetcher.h"

@interface UserFetcherTestCase : TestCaseWithAuthentication {
	UserFetcher *userFetcher;
}
@end

@implementation UserFetcherTestCase

- (void) tearDown {
	[userFetcher release]; userFetcher = nil;
}

- (void) testGetMeResourceSuccess {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchMeResponse:)];
	[self prepare];
	[userFetcher fetchMe];
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) testGetUserResourceSuccess {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchUserByIdResponse:)];
	[self prepare];
	[userFetcher getUserById:[NSNumber numberWithInt:7520378]];
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchMeResponse:(User *)me {
	// Assuming me is the manderson user from the standard authentication
	GHAssertEqualObjects(me.userName, @"manderson", @"Expected the me resource user's userName to be manderson");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMeResourceSuccess)];
}

- (void) fetchUserByIdResponse:(User *)user {
	// Assuming user is the manderson user from the standard authentication
	GHAssertEqualObjects(user.userName, @"manderson", @"Expected the user resource user's userName to be manderson");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetUserResourceSuccess)];
}

@end
