//
//  ActivityStreamActorDeserializationTestCase.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamActor.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface ActivityStreamActorDeserializationTestCase : GHTestCase { }
@end

@implementation ActivityStreamActorDeserializationTestCase

- (void) testDeserializeActivityStreamActorFromJSON {  
    
    // Load the JSON from the file system, instead of compiling it in. If we compile in \n and \r characters, they are
    // converted to literals in the string passed to the JSON parser, and it causes SBJSON to choke. If they are read
    // in from a file, however, everything works fine, because the compiler never swaps them with actual characters.
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ActivityStreamActor" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath encoding:NSASCIIStringEncoding error:NULL];
    
    // Create a parser, parse the JSON into a dictionary
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    NSError* e = [[NSError alloc] init];
    NSDictionary* activityStreamActorDictionary = (NSDictionary*)[parser objectWithString:jsonStr error:&e];
    
    // From the dictionary, build an ActivityStreamItem object
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:activityStreamActorDictionary];
    ActivityStreamActor* activityStreamActor = [[[ActivityStreamActor alloc] initWithCoder:unarchiver] autorelease];
    
    // Test some assertions
    GHAssertEqualStrings(activityStreamActor.role, @"STUD", @"Expected role to be 'STUD'");
    GHAssertEquals(activityStreamActor.referenceId, 4822785, @"Expected referenced ID to be 4822785");
    GHAssertEqualStrings(activityStreamActor.id, @"http://m-api.ecollege.com/users/4822785", @"Expected id to be 'http://m-api.ecollege.com/users/4822785'");
    GHAssertEqualStrings(activityStreamActor.title, @"Kai Johnson", @"Expecting title to be 'Kai Johnson'");
    GHAssertEqualStrings(activityStreamActor.objectType, @"enrolled-user", @"Expecting objectType to be 'enrolled-user'");
}

@end
