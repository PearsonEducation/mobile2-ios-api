//
//  ActivityStreamItemDeserializationTestCase.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamItem.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"
#import "NSDateUtilities.h"

@interface ActivityStreamItemDeserializationTestCase : GHTestCase { }
@end

@implementation ActivityStreamItemDeserializationTestCase

- (void) testDeserializeActivityStreamItemFromJSON {  
    
    // Load the JSON from the file system, instead of compiling it in. If we compile in \n and \r characters, they are
    // converted to literals in the string passed to the JSON parser, and it causes SBJSON to choke. If they are read
    // in from a file, however, everything works fine, because the compiler never swaps them with actual characters.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ActivityStreamItem" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSASCIIStringEncoding error:NULL];
    
    // Create a parser, parse the JSON into a dictionary
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSError* e = [[NSError alloc] init];
    NSDictionary* activityStreamItemDictionary = (NSDictionary*)[parser objectWithString:jsonStr error:&e];

    // From the dictionary, build an ActivityStreamItem object
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:activityStreamItemDictionary];
    ActivityStreamItem *activityStreamItem = [[[ActivityStreamItem alloc] initWithCoder:unarchiver] autorelease];
    
    // Test some assertions
    GHAssertEqualStrings(activityStreamItem.id,@"http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336/responses/128179417", @"Expecting id to equal: http://m-api.ecollege.com/courses/4282262/threadeddiscussions/100103637080/topics/4048336/responses/128179417" );
    GHAssertEqualStrings([activityStreamItem.postedTime iso8601DateString], @"2011-02-22T10:08:24Z", @"Expected date string representations to match");                          
    GHAssertNotNil(activityStreamItem.actor, @"Actor should not be nil");
    GHAssertEqualStrings(activityStreamItem.verb, @"post", @"Expected verb to be 'post'");
    GHAssertNotNil(activityStreamItem.object, @"Object should not be nil");
    GHAssertNotNil(activityStreamItem.target, @"Target should not be nil");
}

@end
