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
	NSString *urlString = [NSString stringWithFormat:@"%@/me.json", M_API_URL];
	[self performSelectorInBackground:@selector(loadDataFromURLString:) withObject:urlString];
}

- (void) getUserById:(NSInteger)userId {
	NSString *urlString = [NSString stringWithFormat:@"%@/users/%d.json", M_API_URL, userId];
	[self performSelectorInBackground:@selector(loadDataFromURLString:) withObject:urlString];
}

- (void) dataDidFinishLoading {
	NSError *deserializationError = nil;
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *parsedDictionary = (NSDictionary *)[parser objectWithString:jsonString error:&deserializationError];
	
	id typedObject;
	ECJSONUnarchiver *unarchiver;
	NSDictionary *targetDictionary;
	if (deserializationError) {
		typedObject = deserializationError;
	} else if ([parsedDictionary objectForKey:@"error"]) {
		targetDictionary = [parsedDictionary objectForKey:@"error"];
		NSString *errorMessage = [targetDictionary objectForKey:@"message"];
		NSDictionary *info = [NSDictionary dictionaryWithObject:errorMessage forKey:@"message"];
		typedObject = [NSError errorWithDomain:EC_API_ERROR_DOMAIN code:responseStatusCode userInfo:info];
	} else {
		if ([parsedDictionary objectForKey:@"me"]) {
			targetDictionary = [parsedDictionary objectForKey:@"me"];
		} else if ([parsedDictionary objectForKey:@"users"]) {
			NSArray *array = [parsedDictionary objectForKey:@"users"];
			targetDictionary = [array objectAtIndex:0];
		}
		unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
		typedObject = [[[User alloc] initWithCoder:unarchiver] autorelease];
	}
    

	[parser release];
	[jsonString release];
	[self performSelectorOnMainThread:@selector(informDelegateOfResponse:)
						   withObject:typedObject
						waitUntilDone:NO];
}

@end
