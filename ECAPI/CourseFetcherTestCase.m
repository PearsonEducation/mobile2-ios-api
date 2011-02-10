//
//  CourseFetcherTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/10/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TestCaseWithAuthentication.h"
#import "Course.h"
#import "CourseFetcher.h"

@interface CourseFetcherTestCase : TestCaseWithAuthentication {
	CourseFetcher *courseFetcher;
}
@end

@implementation CourseFetcherTestCase

- (void) tearDown {
	[courseFetcher release]; courseFetcher = nil;
}

- (void) testGetMyCurrentCoursesSuccess {
    courseFetcher = [[CourseFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchMyCurrentCoursesSuccess:)];
    [self prepare];
    [courseFetcher fetchMyCurrentCourses];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchMyCurrentCoursesSuccess:(NSArray *)currentCourses {
	// Assuming me is the manderson user from the standard authentication
    // This is a brittle test, but it's mostly for bootstrapping the API
    NSInteger count = [currentCourses count];
	GHAssertEquals(5, count, @"Expected the current course list size to be 5");
    Course *firstCourse = (Course *)[currentCourses objectAtIndex:0];
    GHAssertTrue(([firstCourse isKindOfClass:[Course class]]), @"Expected first object in course list to be a Course");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMyCurrentCoursesSuccess)];
}


@end