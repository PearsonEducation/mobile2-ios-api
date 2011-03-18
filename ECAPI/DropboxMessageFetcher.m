//
//  DropboxMessageFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DropboxMessageFetcher.h"
#import "ECJSONUnarchiver.h"

@implementation DropboxMessageFetcher

- (void)fetchDropboxMessageForCourseId:(NSInteger)courseId andBasketId:(NSString*)basketId andMessageId:(NSString*)messageId {
    NSString* url = [NSString stringWithFormat:@"%@/courses/%d/dropboxbaskets/%@/messages/%@", M_API_URL, courseId, basketId, messageId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];
}

- (id) deserializeMe:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
//	if ([parsedDictionary objectForKey:@"activityStream"]) {
//		NSDictionary *targetDictionary = [parsedDictionary objectForKey:@"activityStream"];
//		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
//        ActivityStream* activityStream = [[[ActivityStream alloc] initWithCoder:unarchiver] autorelease];
//        return activityStream;
//	} else {
//		return nil;
//	}
    return nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
