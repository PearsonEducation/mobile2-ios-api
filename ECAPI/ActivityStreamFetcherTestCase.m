//
//  ActivityStreamFetcherTestCase.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TestCaseWithAuthentication.h"
#import "ActivityStreamItem.h"
#import "ActivityStreamFetcher.h"
#import "ActivityStream.h"

@interface ActivityStreamFetcherTestCase : TestCaseWithAuthentication {
    ActivityStreamFetcher* activityStreamFetcher;
}
@end

@implementation ActivityStreamFetcherTestCase

- (void) tearDown {
    [activityStreamFetcher release]; 
    activityStreamFetcher = nil;
}

#pragma mark Get My Activity Stream tests

- (void) testGetMyActivityStreamSuccess {
    activityStreamFetcher = [[ActivityStreamFetcher alloc] 
                             initWithDelegate:self 
                             responseSelector:@selector(getMyActivityStreamSuccessHandler:)];
    [self prepare];
    [activityStreamFetcher fetchMyActivityStream];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) getMyActivityStreamSuccessHandler:(ActivityStream*)activityStream {
    GHAssertEqualStrings(activityStream.title, @"Activity Feed for Jason Barnes", nil);
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMyActivityStreamSuccess)];
}

# pragma mark Get Activity Stream For User tests

- (void) testGetActivityStreamForUserSuccess {
    activityStreamFetcher = [[ActivityStreamFetcher alloc] 
                             initWithDelegate:self 
                             responseSelector:@selector(getActivityStreamForUserSuccessHandler:)];        
    [self prepare];
    [activityStreamFetcher fetchActivityStreamForUserId:[NSNumber numberWithInt:4822784]];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];    
}

- (void) getActivityStreamForUserSuccessHandler:(ActivityStream*)activityStream {
    GHAssertEqualStrings(activityStream.title, @"Activity Feed for Jason Barnes", nil);
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetActivityStreamForUserSuccess)];    
}

- (void) testGetActivityStreamForUserFailure {
    activityStreamFetcher = [[ActivityStreamFetcher alloc] 
                             initWithDelegate:self 
                             responseSelector:@selector(getActivityStreamForUserFailureHandler:)];    
    [self prepare];
    [activityStreamFetcher fetchActivityStreamForUserId:[NSNumber numberWithInt:0]]; // <-- should cause an error
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];    
}

- (void) getActivityStreamForUserFailureHandler:(ActivityStream*)activityStream { // <-- should actually be an NSError
    GHAssertTrue(([activityStream isKindOfClass:[NSError class]]), @"Expected returned object to be an error");
	NSError *error = (NSError *)activityStream;
	NSDictionary *userInfo = [error userInfo];
	NSString *errorMessage = [userInfo objectForKey:@"message"];
	GHAssertEqualStrings(errorMessage, @"Not Found", @"Expected returned error message to be 'Not Found'");
	GHAssertEquals(404, [error code], @"Expected Error Code to be 404");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetActivityStreamForUserFailure)];
}

@end
