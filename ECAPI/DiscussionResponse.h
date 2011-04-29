//
//  DiscussionResponse.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DiscussionResponse : NSObject {
    NSNumber* discussionResponseId;
    NSString* title;
    NSString* description;
    User* author;
    NSDate* postedDate;
}

@property (nonatomic, retain) NSNumber* discussionResponseId;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) User* author;
@property (nonatomic, retain) NSDate* postedDate;

@end
