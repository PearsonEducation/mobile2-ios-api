//
//  UserFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserFetcher.h"
#import "User.h"
#import "ECConstants.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"
#import "RosterUser.h"

@implementation UserFetcher

- (void) fetchMe {
	NSString *url = [NSString stringWithFormat:@"%@/me.json", M_API_URL];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];
}

- (void) fetchUserById:(NSNumber *)userId {
	NSString *url = [NSString stringWithFormat:@"%@/users/%@.json", M_API_URL, userId];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeSingleUserFromArray:)];
}

- (void) fetchRosterForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/roster", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeRoster:)];
}

- (id) deserializeMe:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"me"]) {
		NSDictionary *targetDictionary = [parsedDictionary objectForKey:@"me"];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
		return [[[User alloc] initWithCoder:unarchiver] autorelease];
	} else {
		return nil;
	}
}

- (id) deserializeSingleUserFromArray:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"users"]) {
		NSArray *array = [parsedDictionary objectForKey:@"users"];
		NSDictionary *targetDictionary = [array objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
		return [[[User alloc] initWithCoder:unarchiver] autorelease];
	} else {
		return nil;
	}
}

- (id) deserializeRoster:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"roster"]) {
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray *users = [unarchiver decodeArrayForKey:@"roster" ofType:[RosterUser class]];
        return users;
	} else {
		return nil;
	}
}

@end
