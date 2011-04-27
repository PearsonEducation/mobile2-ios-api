//
//  ThreadTopicFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 4/26/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface ThreadTopicFetcher : ECAuthenticatedFetcher {
	NSNumber *threadId;
}

- (void) fetchDiscussionTopicsForCourseId:(NSInteger)courseId threadId:(NSNumber *)threadId;

@end
