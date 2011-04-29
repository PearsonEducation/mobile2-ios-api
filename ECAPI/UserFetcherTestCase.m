//
//  UserFetcherTestCase.m
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

- (void) fetchMeResponse:(User *)me {
	// Assuming me is the veronicastudent3 user from the inherited test case
	GHAssertEqualObjects(me.userName, @"veronicastudent3", @"Expected the me resource user's userName to be veronicastudent3");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMeResourceSuccess)];
}

- (void) testGetUserResourceSuccess {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchUserByIdResponse:)];
	[self prepare];
	[userFetcher fetchUserById:[NSNumber numberWithInt:4822784]];
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchUserByIdResponse:(User *)user {
	// Assuming user is the veronicastudent3 user from the standard authentication
	GHAssertEqualObjects(user.userName, @"veronicastudent3", @"Expected the user resource user's userName to be veronicastudent3");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetUserResourceSuccess)];
}

- (void) testGetUserResourceFailure {
	userFetcher = [[UserFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchUserByIdFailureResponse:)];
	[self prepare];
	[userFetcher fetchUserById:[NSNumber numberWithInt:0]]; // <- should be "not found"
	[self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchUserByIdFailureResponse:(User *)user {// <-- should actually be an NSError
	GHAssertTrue(([user isKindOfClass:[NSError class]]), @"Expected returned object to be an error");
	NSError *error = (NSError *)user;
	NSDictionary *userInfo = [error userInfo];
	NSString *errorMessage = [userInfo objectForKey:@"message"];
	GHAssertEqualStrings(errorMessage, @"Not Found", @"Expected returned error message to be 'Not Found'");
	GHAssertEquals(404, [error code], @"Expected Error Code to be 404");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetUserResourceFailure)];
}

@end
