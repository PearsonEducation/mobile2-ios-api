//
//  UserFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserFetcher.h"
#import "User.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@implementation UserFetcher

- (void) fetchMe {
	NSString *urlString = [NSString stringWithFormat:@"%@/me.json", M_API_URL];
	[self performSelectorInBackground:@selector(loadDataFromURLString:) withObject:urlString];
}

- (void) getUserById:(NSNumber *)userId {
	NSString *urlString = [NSString stringWithFormat:@"%@/users/%d.json", M_API_URL, [userId intValue]];
	[self performSelectorInBackground:@selector(loadDataFromURLString:) withObject:urlString];
}

- (void) dataDidFinishLoading {
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	// TODO: handle parse errors
	NSDictionary *parsedDictionary = (NSDictionary *)[parser objectWithString:jsonString error:NULL];
	// TODO: handle domain errors
    
	id typedObject;
	ECJSONUnarchiver *unarchiver;
	NSDictionary *targetDictionary;
	if ([parsedDictionary objectForKey:@"me"]) {
		targetDictionary = [parsedDictionary objectForKey:@"me"];
		unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
		typedObject = [[[User alloc] initWithCoder:unarchiver] autorelease];
	} else if ([parsedDictionary objectForKey:@"users"]) {
		NSArray *array = [parsedDictionary objectForKey:@"users"];
		targetDictionary = [array objectAtIndex:0];
		unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
		typedObject = [[[User alloc] initWithCoder:unarchiver] autorelease];
	}

	[parser release];
	[jsonString release];
	[self performSelectorOnMainThread:@selector(informDelegateOfSuccess:) withObject:typedObject waitUntilDone:NO];
}

@end
