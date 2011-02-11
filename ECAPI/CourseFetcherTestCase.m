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

- (void) testFetchCourseByIdSuccess {
    courseFetcher = [[CourseFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchCourseSuccess:)];
    [self prepare];
    [courseFetcher fetchCourseById:2809780];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchCourseSuccess:(Course *)course {
	GHAssertNotNil(course, @"Expected course to not be nil");
	GHAssertEqualStrings(course.title, @"ERC - An Introduction", @"Expected course title to be ERC - An Introduction");
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchCourseByIdSuccess)];
}

- (void) testGetMyCurrentCoursesSuccess {
    courseFetcher = [[CourseFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchMyCurrentCoursesSuccess:)];
    [self prepare];
    [courseFetcher fetchMyCurrentCourses];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
}

- (void) fetchMyCurrentCoursesSuccess:(NSArray *)currentCourses {
	// Assuming me is the veronicastudent3 user from the superclass
    // This is a brittle test, but it's mostly for bootstrapping the API
    NSInteger count = [currentCourses count];
	GHAssertEquals(3, count, @"Expected the current course list count for veronicastudent3 to be 3");
    Course *firstCourse = (Course *)[currentCourses objectAtIndex:0];
    GHAssertTrue(([firstCourse isKindOfClass:[Course class]]), @"Expected first object in course list to be a Course");
	[self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetMyCurrentCoursesSuccess)];
}

//- (void) testFetchInstructorsForCourseSuccess {
//    courseFetcher = [[CourseFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchInstructorsForCourseSuccess:)];
//    [self prepare];
//    [courseFetcher fetchInstructorsForCourseWithId:2809780];
//    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
//}


@end