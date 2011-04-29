//
//  ActivityStreamObjectDeserializationTestCase.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"
#import "ActivityStreamObject.h"

@interface ActivityStreamObjectDeserializationTestCase : GHTestCase { }
@end

@implementation ActivityStreamObjectDeserializationTestCase

- (void) testDeserializeActivityStreamObjectFromJSON {  
    
    // Load the JSON from the file system, instead of compiling it in. If we compile in \n and \r characters, they are
    // converted to literals in the string passed to the JSON parser, and it causes SBJSON to choke. If they are read
    // in from a file, however, everything works fine, because the compiler never swaps them with actual characters.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ActivityStreamObject" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSASCIIStringEncoding error:NULL];
    
    // Create a parser, parse the JSON into a dictionary
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSError* e = [[NSError alloc] init];
    NSDictionary* activityStreamObjectDictionary = (NSDictionary*)[parser objectWithString:jsonStr error:&e];
    
    // From the dictionary, build an ActivityStreamItem object
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:activityStreamObjectDictionary];
    ActivityStreamObject* activityStreamObject = [[[ActivityStreamObject alloc] initWithCoder:unarchiver] autorelease];
    
    // Test some assertions
    GHAssertEquals([activityStreamObject.courseId intValue], 4282262, @"Expected courseId to be 4282262");
    GHAssertEqualStrings(activityStreamObject.referenceId, @"128179417", @"Expected referenceId to be '128179417'");
    GHAssertEqualStrings(activityStreamObject.id, @"http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336/responses/128179417", @"Expected id to be 'http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336/responses/128179417'");
    GHAssertEqualStrings(activityStreamObject.title, @"hhhr", @"Expected referenceId to be 'hhhr'");
    GHAssertEqualStrings(activityStreamObject.summary, @"testing", @"Expected referenceId to be 'testing'");
    GHAssertEqualStrings(activityStreamObject.objectType, @"thread-post", @"Expected referenceId to be 'thread-post'");
}

@end
