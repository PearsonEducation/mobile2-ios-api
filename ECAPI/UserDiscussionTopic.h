//
//  UserDiscussionTopic.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscussionTopic.h"
#import "ResponseCount.h"

@interface UserDiscussionTopic : NSObject {
    NSString* userDiscussionTopicId;
    DiscussionTopic* topic;
    ResponseCount* childResponseCounts;
}

- (BOOL)isActive;
- (NSString*)getUnitTitle;

@property (nonatomic, retain) NSString* userDiscussionTopicId;
@property (nonatomic, retain) DiscussionTopic* topic;
@property (nonatomic, retain) ResponseCount* childResponseCounts;

@end
