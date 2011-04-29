//
//  TextMultimediaFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 4/27/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TextMultimediaFetcher.h"

@implementation TextMultimediaFetcher

- (void) fetchHTMLContentForCourseId:(NSInteger)courseId contentId:(NSNumber *)contentId {
	self.returnRawResponse = YES;
	NSString *url = [NSString stringWithFormat:@"%@/courses/%d/textMultimedias/%qu/content.html", M_API_URL, courseId, [contentId longLongValue]];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeHTML:)];
}
	
- (id) deserializeHTML:(id)parsedData {
	return parsedData;
}

@end
