//
//  CourseFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/10/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "CourseFetcher.h"
#import "Course.h"
#import "User.h"
#import "Grade.h"
#import "ECConstants.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface CourseFetcher (Private)
- (NSArray *) deserializeListOfUsersFromArray:(NSArray *)list;
@end

@implementation CourseFetcher

- (void) fetchCourseById:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeSingleCourseFromArray:)];
}

- (id) deserializeSingleCourseFromArray:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"courses"]) {
		NSArray *courses = [parsedDictionary objectForKey:@"courses"];
		NSDictionary *courseDictionary = [courses objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:courseDictionary];
		return [[[Course alloc] initWithCoder:unarchiver] autorelease];
	} else {
		return nil;
	}
}

- (void) fetchMyCurrentCourses {
    NSString *url = [NSString stringWithFormat:@"%@/me/currentcourses_moby", M_API_URL];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfCurrentCourses:)];
}

- (id) deserializeListOfCurrentCourses:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"currentCourses"]) {
		ECJSONUnarchiver *unarchiver = nil;
		NSArray *targetArray = [parsedDictionary objectForKey:@"currentCourses"];
		NSMutableArray *courseArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
		for (NSDictionary *courseDictionary in targetArray) {
			unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:courseDictionary];
			[courseArray addObject:[[[Course alloc] initWithCoder:unarchiver] autorelease]];
		}
		return [NSArray arrayWithArray:courseArray];
	} else {
		return nil;
	}
}

- (void) fetchInstructorsForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/instructors.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfInstructors:)];
}

- (id) deserializeListOfInstructors:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"instructors"]) {
		NSArray *targetArray = [parsedDictionary objectForKey:@"instructors"];
		return [self deserializeListOfUsersFromArray:targetArray];
	} else {
		return nil;
	}
}

- (void) fetchTeachingAssistantsForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/teachingAssistants.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfTeachingAssistants:)];
}

- (id) deserializeListOfTeachingAssistants:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"teachingAssistants"]) {
		NSArray *targetArray = [parsedDictionary objectForKey:@"teachingAssistants"];
		return [self deserializeListOfUsersFromArray:targetArray];
	} else {
		return nil;
	}
}

- (void) fetchStudentsForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/students.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfStudents:)];
}

- (id) deserializeListOfStudents:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"students"]) {
		NSArray *targetArray = [parsedDictionary objectForKey:@"students"];
		return [self deserializeListOfUsersFromArray:targetArray];
	} else {
		return nil;
	}
}

- (void) fetchMyGradeToDateForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/me/courses/%@/coursegradetodate.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeGradeToDate:)];
}

- (id) deserializeGradeToDate:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"courseGradeToDate"]) {
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:[parsedDictionary objectForKey:@"courseGradeToDate"]];
		return [[[Grade alloc] initWithCoder:unarchiver] autorelease];
	} else {
		return nil;
	}
}

- (NSArray *) deserializeListOfUsersFromArray:(NSArray *)list {
	NSMutableArray *usersArray = [NSMutableArray arrayWithCapacity:[list count]];
	ECJSONUnarchiver *unarchiver = nil;
	for (NSDictionary *userDictionary in list) {
		unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:userDictionary];
		[usersArray addObject:[[[User alloc] initWithCoder:unarchiver] autorelease]];
	}
	return [NSArray arrayWithArray:usersArray];
}



@end
