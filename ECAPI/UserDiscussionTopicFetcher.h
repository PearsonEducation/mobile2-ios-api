//
//  UserDiscussionTopicFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"


@interface UserDiscussionTopicFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchDiscussionTopicById:(NSNumber *)userId andTopicId:(NSNumber *)topicId;
- (void)fetchDiscussionTopicById:(NSString*)userTopicId;
- (void)fetchDiscussionTopicsForCourseIds:(NSArray*)courseIds;

@end
