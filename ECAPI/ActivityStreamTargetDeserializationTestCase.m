//
//  ActivityStreamTargetDeserializationTestCAse.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"
#import "ActivityStreamTarget.h"


@interface ActivityStreamTargetDeserializationTestCase : GHTestCase { }
@end

@implementation ActivityStreamTargetDeserializationTestCase

- (void) testDeserializeActivityStreamTargetFromJSON {  
    
    // Load the JSON from the file system, instead of compiling it in. If we compile in \n and \r characters, they are
    // converted to literals in the string passed to the JSON parser, and it causes SBJSON to choke. If they are read
    // in from a file, however, everything works fine, because the compiler never swaps them with actual characters.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ActivityStreamTarget" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSASCIIStringEncoding error:NULL];
    
    // Create a parser, parse the JSON into a dictionary
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSError* e = [[NSError alloc] init];
    NSDictionary* activityStreamTargetDictionary = (NSDictionary*)[parser objectWithString:jsonStr error:&e];
    
    // From the dictionary, build an ActivityStreamItem Target
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:activityStreamTargetDictionary];
    ActivityStreamTarget* activityStreamTarget = [[[ActivityStreamTarget alloc] initWithCoder:unarchiver] autorelease];
    
    // Test some assertions
    GHAssertEquals(activityStreamTarget.courseId, 4282262, @"Expected courseId to be 4282262");
    GHAssertEqualStrings(activityStreamTarget.referenceId, @"4048336", @"Expected referenceId to be '4048336'");
    GHAssertEqualStrings(activityStreamTarget.id, @"http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336", @"Expected id to be 'http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336'");
    GHAssertEqualStrings(activityStreamTarget.title, @"Get to Know Your Classmates", @"Expected referenceId to be 'Get to Know Your Classmates'");
    GHAssertEqualStrings(activityStreamTarget.summary, @"\r\n<p>Get to know your classmates. Please tell everyone the following things: </p>\r\n<ul>\r\n<li>Name, </li><li>Major </li><li>Year in School, </li><li>Special interests and Activities </li><li>What you want to gain from this course </li></ul>\r\n<p>Please respond to at least 5 of your classmates after posting your introduction.\r\n</p>\r\n", @"Expected referenceId to be '\r\n<p>Get to know your classmates. Please tell everyone the following things: </p>\r\n<ul>\r\n<li>Name, </li><li>Major </li><li>Year in School, </li><li>Special interests and Activities </li><li>What you want to gain from this course </li></ul>\r\n<p>Please respond to at least 5 of your classmates after posting your introduction.\r\n</p>\r\n'");
    GHAssertEqualStrings(activityStreamTarget.objectType, @"thread-topic", @"Expected referenceId to be 'thread-topic'");
}

@end
