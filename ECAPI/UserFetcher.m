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

@implementation UserFetcher

- (void) fetchMe {
	NSString *url = [NSString stringWithFormat:@"%@/me.json", M_API_URL];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];
}

- (void) fetchUserById:(NSInteger)userId {
	NSString *url = [NSString stringWithFormat:@"%@/users/%d.json", M_API_URL, userId];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeSingleUserFromArray:)];
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

@end
