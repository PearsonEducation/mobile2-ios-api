//
//  Course.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/3/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Course.h"
#import "ECUtils.h"

@implementation Course
@synthesize courseId, displayCourseCode, title, callNumbers, instructors, teachingAssistants, students;


+ (Course *) courseFromDictionary:(NSDictionary *)courseDictionary {
	Course *course = [[[Course alloc] init] autorelease];
	course.courseId = [courseDictionary objectForKey:@"id"];
	course.displayCourseCode = [ECUtils stringOrEmptyStringFromStringOrNull:[courseDictionary objectForKey:@"displayCourseCode"]];
	course.title = [ECUtils stringOrEmptyStringFromStringOrNull:[courseDictionary objectForKey:@"title"]];
	return course;
}

@end
