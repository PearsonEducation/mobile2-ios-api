//
//  UserDiscussionResponseFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface UserDiscussionResponseFetcher : ECAuthenticatedFetcher {
    
}

- (void)postResponseToTopicWithId:(NSString*)topicId andTitle:(NSString*)title andText:(NSString*)text;
- (void)fetchUserDiscussionResponseByUserId:(NSInteger)userId andResponseId:(NSInteger)responseId;
- (void)fetchUserDiscussionResponseByUserResponseId:(NSString*)userResponseId;
- (void)fetchDiscussionResponsesForResponseId:(NSString*)userDiscussionResponseId;
- (void)fetchUserDiscussionResponsesForTopicId:(NSString*)userDiscussionTopicId;
- (void)postResponseToResponseWithId:(NSString*)topicId andTitle:(NSString*)title andText:(NSString*)text;
- (void)postResponseToTopicWithId:(NSString*)topicId andTitle:(NSString*)title andText:(NSString*)text;
- (void)markResponseId:(NSString*)responseId asRead:(BOOL)readStatus;

@end
