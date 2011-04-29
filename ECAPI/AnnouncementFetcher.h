//
//  AnnouncementFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"


@interface AnnouncementFetcher : ECAuthenticatedFetcher {
    
}

- (void) fetchAnnouncementsForCourseWithId:(NSNumber *)courseId;
- (void) fetchAnnouncementWithId:(NSNumber *)announcementId forCourseId:(NSNumber *)courseId;

@end
