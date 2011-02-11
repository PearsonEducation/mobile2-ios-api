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
#import "ECConstants.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@implementation CourseFetcher

- (void) fetchCourseById:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d.json", M_API_URL, courseId];
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

- (void) fetchInstructorsForCourseWithId:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d/instructors.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfInstructors:)];
}

- (id) deserializeListOfInstructors:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"instructors"]) {
		ECJSONUnarchiver *unarchiver = nil;
		NSArray *targetArray = [parsedDictionary objectForKey:@"instructors"];
		NSMutableArray *instructorsArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
		for (NSDictionary *instructorDictionary in targetArray) {
			unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:instructorDictionary];
			[instructorsArray addObject:[[[User alloc] initWithCoder:unarchiver] autorelease]];
		}
		return [NSArray arrayWithArray:instructorsArray];
	} else {
		return nil;
	}
}

- (void) fetchTeachingAssistantsForCourseWithId:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d/teachingAssistants.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfTeachingAssistants:)];
}

- (id) deserializeListOfTeachingAssistants:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"teachingAssistants"]) {
		ECJSONUnarchiver *unarchiver = nil;
		NSArray *targetArray = [parsedDictionary objectForKey:@"teachingAssistants"];
		NSMutableArray *assistantsArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
		for (NSDictionary *assistantDictionary in targetArray) {
			unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:assistantDictionary];
			[assistantsArray addObject:[[[User alloc] initWithCoder:unarchiver] autorelease]];
		}
		return [NSArray arrayWithArray:assistantsArray];
	} else {
		return nil;
	}
}

- (void) fetchStudentsForCourseWithId:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d/students.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfStudents:)];
}

- (id) deserializeListOfStudents:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"students"]) {
		ECJSONUnarchiver *unarchiver = nil;
		NSArray *targetArray = [parsedDictionary objectForKey:@"students"];
		NSMutableArray *studentsArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
		for (NSDictionary *studentDictionary in targetArray) {
			unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:studentDictionary];
			[studentsArray addObject:[[[User alloc] initWithCoder:unarchiver] autorelease]];
		}
		return [NSArray arrayWithArray:studentsArray];
	} else {
		return nil;
	}
}

@end
