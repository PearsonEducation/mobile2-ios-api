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

@implementation UserFetcher

- (void) fetchMe {
	NSString *urlString = [NSString stringWithFormat:@"%@/me.json", M_API_URL];
	[self loadDataFromURLString:urlString];
}

- (void) dataDidFinishLoading {
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	// TODO: handle errors
	NSDictionary *parsedDictionary = (NSDictionary *)[parser objectWithString:jsonString error:NULL];
	id typedObject;
	if ([parsedDictionary objectForKey:@"me"]) {
		typedObject = [User userFromDictionary:[parsedDictionary objectForKey:@"me"]];
	} else if ([parsedDictionary objectForKey:@"users"]) {
		//typedObject = [User userFromDictionary:[parsedDictionary objectForKey:@"me"]];
	}

	[parser release];
	[jsonString release];
	[self informDelegateOfSuccess:typedObject];
}

@end
