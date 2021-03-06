//
//  UserDeserializationTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "User.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface UserDeserializationTestCase : GHTestCase { }
@end

@implementation UserDeserializationTestCase

- (void) testDeserializeUserFromMeJSON {
	NSString *meJSON = @"{\"me\":{\"id\":7520378,\"userName\":\"manderson\",\"firstName\":\"Mary\",\"lastName\":\"Anderson\",\"emailAddress\":\"maryanderson@ecollege.com\",\"clientString\":\"sandbox\"}}";
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
	NSDictionary *userDictionary = (NSDictionary *)[parser objectWithString:meJSON];
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:[userDictionary objectForKey:@"me"]];
    
	User *user = [[[User alloc] initWithCoder:unarchiver] autorelease];
	GHAssertEquals([user.userId intValue], 7520378, @"Expected user id to equal 7520378");
	GHAssertEqualObjects(user.userName, @"manderson", @"Expected userName to equal manderson");
	GHAssertEqualObjects(user.firstName, @"Mary", @"Expected firstName to equal Mary");
	GHAssertEqualObjects(user.lastName, @"Anderson", @"Expected lastName to equal Anderson");
	GHAssertEqualObjects(user.emailAddress, @"maryanderson@ecollege.com", @"Expected emailAddress to equal maryanderson@ecollege.com");
	GHAssertEqualObjects(user.clientString, @"sandbox", @"Expected clientString to equal sandbox");
}

@end
