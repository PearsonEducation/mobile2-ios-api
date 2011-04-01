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

- (void) fetchAnnouncementsForCourseWithId:(NSInteger)courseId;
- (void) fetchAnnouncementWithId:(NSInteger)announcementId forCourseId:(NSInteger)courseId;

@end
