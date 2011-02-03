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

- (void) testGetMeResource {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self
									   responseSelector:@selector(fetchMeSuccess:)
										  errorSelector:@selector(fetchMeFailedWithMessage:)];
	[self prepare];
	[userFetcher fetchMe];
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) testGetUserResource {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self
									   responseSelector:@selector(fetchUserByIdSuccess:)
										  errorSelector:@selector(fetchUserByIdFailedWithMessage:)];
	[self prepare];
	[userFetcher getUserById:[NSNumber numberWithInt:7520378]];
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchMeSuccess:(User *)me {
	// Assuming me is the manderson user from the standard authentication
	GHAssertEqualObjects(me.userName, @"manderson", @"Expected the me resource user's userName to be manderson");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMeResource)];
}

- (void) fetchUserByIdSuccess:(User *)user {
	// Assuming user is the manderson user from the standard authentication
	GHAssertEqualObjects(user.userName, @"manderson", @"Expected the user resource user's userName to be manderson");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetUserResource)];
}

- (void) fetchMeFailedWithMessage:(NSString *)errorMessage {
	
}

- (void) fetchUserByIdFailedWithMessage:(NSString *)errorMessage {
	
}

@end
