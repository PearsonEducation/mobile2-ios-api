//
//  AnnouncementFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECJSONUnarchiver.h"
#import "AnnouncementFetcher.h"
#import "Announcement.h"

@implementation AnnouncementFetcher

- (void) fetchAnnouncementsForCourseWithId:(NSInteger)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%d/announcements", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfAnnouncements:)];
}

- (id) deserializeListOfAnnouncements:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"announcements"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray* announcements = [unarchiver decodeArrayForKey:@"announcements" ofType:[Announcement class]];
        return announcements;
	} else {
		return nil;
	}
}

@end
