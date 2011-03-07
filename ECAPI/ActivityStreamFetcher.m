//
//  ActivityStreamFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamFetcher.h"
#import "ECJSONUnarchiver.h"
#import "ACtivityStream.h"

@implementation ActivityStreamFetcher

- (void) fetchMyActivityStream {
	NSString *url = [NSString stringWithFormat:@"%@/me/whatshappeningfeed.json", M_API_URL];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];
}

- (void) fetchActivityStreamForUserId:(NSInteger)userId {
	NSString *url = [NSString stringWithFormat:@"%@/users/%d/whatshappeningfeed.json", M_API_URL, userId];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];    
}

- (id) deserializeMe:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"activityStream"]) {
		NSDictionary *targetDictionary = [parsedDictionary objectForKey:@"activityStream"];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
        ActivityStream* activityStream = [[[ActivityStream alloc] initWithCoder:unarchiver] autorelease];
        return activityStream;
	} else {
		return nil;
	}
}

@end
