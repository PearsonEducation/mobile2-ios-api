//
//  UserDiscussionResponseFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"
#import "UserDiscussionResponse.h"
#import "UserDiscussionTopic.h"

@interface UserDiscussionResponseFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchUserDiscussionResponseByUserId:(NSInteger)userId andResponseId:(NSInteger)responseId;
- (void)fetchUserDiscussionResponseByUserResponseId:(NSString*)userResponseId;
- (void)fetchDiscussionResponsesForResponse:(UserDiscussionResponse*)userDiscussionResponse;
- (void)fetchUserDiscussionResponseForTopic:(UserDiscussionTopic*)userDiscussionTopic;
- (void)postResponseToResponseId:(NSInteger)responseId andTitle:(NSString*)title andText:(NSString*)text;
- (void)postResponseToTopicId:(NSInteger)topicId andTitle:(NSString*)title andText:(NSString*)text;

@end
