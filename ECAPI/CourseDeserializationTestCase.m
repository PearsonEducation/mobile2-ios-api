//
//  CourseDeserializationTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Course.h"
#import "SBJsonParser.h"

@interface CourseDeserializationTestCase : GHTestCase { }
@end

@implementation CourseDeserializationTestCase

- (void) testDeserializeUnexpandedCourseFromJSON {
	NSString *unexpandedCourseJSON = @"{\"courses\":[{\"id\":3433672,\"displayCourseCode\":\"SOT\",\"title\":\"Student Orientation Tutorial\",\"callNumbers\":[],\"instructors\":{\"links\":[{\"href\":\"https://m-api.ecollege.com/courses/3433672/instructors\",\"rel\":\"self\",\"title\":\"instructors\"}]},\"teachingAssistants\":{\"links\":[{\"href\":\"https://m-api.ecollege.com/courses/3433672/teachingAssistants\",\"rel\":\"self\",\"title\":\"teachingAssistants\"}]},\"students\":{\"links\":[{\"href\":\"https://m-api.ecollege.com/courses/3433672/students\",\"rel\":\"self\","title":\"students\"}]},\"links\":[{\"href\":\"https://m-api.ecollege.com/terms/55886\",\"rel\":\"https://m-api.ecollege.com/rels/term\"}]}]}";
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
	NSDictionary *courseDictionary = (NSDictionary *)[parser objectWithString:unexpandedCourseJSON];
	
	Course *course = [Course courseFromDictionary:[meDictionary objectForKey:@"courses"]];
	GHAssertEqualObjects(course.courseId, [NSNumber numberWithInt:3433672], @"Expected course id to equal 3433672");
}

@end