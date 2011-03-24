//
//  UserDiscussionResponse.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerInfo.h"
#import "DiscussionResponse.h"
#import "ResponseCount.h"

@interface UserDiscussionResponse : NSObject {
    NSString* userDiscussionResponseId;
    BOOL markedAsRead;
    DiscussionResponse* response;
    ResponseCount* childResponseCounts;
}

@property (nonatomic, retain) NSString* userDiscussionResponseId;
@property (nonatomic, assign) BOOL markedAsRead;
@property (nonatomic, retain) DiscussionResponse* response;
@property (nonatomic, retain) ResponseCount* childResponseCounts;

@end
