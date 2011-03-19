//
//  DiscussionTopic.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerInfo.h"

@interface DiscussionTopic : NSObject {
    NSInteger discussionTopicId;
    NSString* title;
    NSString* description;
    NSInteger orderNumber;
    ContainerInfo* containerInfo;
}

@property (nonatomic, assign) NSInteger discussionTopicId;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, assign) NSInteger orderNumber;
@property (nonatomic, retain) ContainerInfo* containerInfo;

@end
