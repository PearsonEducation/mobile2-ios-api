//
//  UpcomingEventItemsFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/21/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UpcomingEventItemsFetcher.h"
#import "ECJSONUnarchiver.h"
#import "UpcomingEventItem.h"

@implementation UpcomingEventItemsFetcher

- (void)fetchMyUpcomingEventItems {
    NSString *url = [NSString stringWithFormat:@"%@/me/upcomingevents", M_API_URL];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUpcomingEventItems:)];
}

- (id)deserializeUpcomingEventItems:(id)parsedData {
    NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
    id returnValue = nil;
	if ([parsedDictionary objectForKey:@"upcomingEvents"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        returnValue = [unarchiver decodeArrayForKey:@"upcomingEvents" ofType:[UpcomingEventItem class]];
	}
    return returnValue;
}

@end
