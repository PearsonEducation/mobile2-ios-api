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

@interface AnnouncementFetcher ()

- (id) deserializeListOfAnnouncements:(id)parsedData;

@end

@implementation AnnouncementFetcher

- (void) fetchAnnouncementsForCourseWithId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/announcements", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeListOfAnnouncements:)];
}

- (void) fetchAnnouncementWithId:(NSNumber *)announcementId forCourseId:(NSNumber *)courseId {
    NSString *url = [NSString stringWithFormat:@"%@/courses/%@/announcements/%@", M_API_URL, courseId, announcementId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeAnnouncementFromArray:)];
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

- (id) deserializeAnnouncementFromArray:(id)parsedData {
    id result = [self deserializeListOfAnnouncements:parsedData];
    if ([result isKindOfClass:[NSArray class]] && [(NSArray*)result count] > 0) {
        return [(NSArray*)result objectAtIndex:0];
    } else {
        return nil;
    }
}

@end
