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

- (void) fetchCourseById:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d.json", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeSingleCourseFromArray:)];
}

- (void) fetchMyCurrentCourses {
    NSString *url = [NSString stringWithFormat:@"%@/me/currentcourses_moby", M_API_URL];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfCurrentCourses:)];
}

- (id) deserializeSingleCourseFromArray:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"courses"]) {
		NSArray *courses = [parsedDictionary objectForKey:@"courses"];
		NSDictionary *courseDictionary = [courses objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:courseDictionary];
		return [[[Course alloc] initWithCoder:unarchiver] autorelease];
	} else {
		return nil;
	}
}

- (id) deserializeListOfCurrentCourses:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"currentCourses"]) {
		ECJSONUnarchiver *unarchiver = nil;
		NSArray *targetArray = [parsedDictionary objectForKey:@"currentCourses"];
		NSMutableArray *courseArray = [NSMutableArray arrayWithCapacity:[targetArray count]];
		for (NSDictionary *courseDictionary in targetArray) {
			unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:courseDictionary];
			[courseArray addObject:[[[Course alloc] initWithCoder:unarchiver] autorelease]];
		}
		return [NSArray arrayWithArray:courseArray];
	} else {
		return nil;
	}
}



@end
