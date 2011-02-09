//
//  Course.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/3/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Course.h"
#import "ECCoder.h"

@implementation Course
@synthesize courseId, displayCourseCode, title, callNumbers, instructors, teachingAssistants, students;


- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self = [super init])) {
		self.courseId = [coder decodeIntegerForKey:@"id"];
		self.displayCourseCode = [coder decodeObjectForKey:@"displayCourseCode"];
		self.title = [coder decodeObjectForKey:@"title"];
	}
	return self;
}

@end
