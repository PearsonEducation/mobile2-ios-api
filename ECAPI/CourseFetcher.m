//
//  CourseFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/10/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "CourseFetcher.h"
#import "Course.h"
#import "ECConstants.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@implementation CourseFetcher

- (void) fetchMyCurrentCourses {
    NSString *url = [NSString stringWithFormat:@"%@/me/currentcourses_moby", M_API_URL];
    [self loadDataFromURLString:url];
}

- (id) parseReturnedData {
	NSError *deserializationError = nil;
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *parsedDictionary = (NSDictionary *)[parser objectWithString:jsonString error:&deserializationError];
	
	id typedObject = nil;
	ECJSONUnarchiver *unarchiver = nil;
    NSArray *targetArray = nil;
	if (deserializationError) {
		typedObject = deserializationError;
	} else if ([parsedDictionary objectForKey:@"error"]) {
		NSDictionary *targetDictionary = [parsedDictionary objectForKey:@"error"];
		NSString *errorMessage = [targetDictionary objectForKey:@"message"];
		NSDictionary *info = [NSDictionary dictionaryWithObject:errorMessage forKey:@"message"];
		typedObject = [NSError errorWithDomain:EC_API_ERROR_DOMAIN code:responseStatusCode userInfo:info];
	} else {
		if ([parsedDictionary objectForKey:@"currentCourses"]) {
			targetArray = [parsedDictionary objectForKey:@"currentCourses"];
            NSMutableArray *courseArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
            for (NSDictionary *courseDictionary in targetArray) {
                unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:courseDictionary];
                [courseArray addObject:[[[Course alloc] initWithCoder:unarchiver] autorelease]];
            }
            typedObject = [NSArray arrayWithArray:courseArray];
		}
	}
    
    
	[parser release];
	[jsonString release];
	return typedObject;
}

@end
