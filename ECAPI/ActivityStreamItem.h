//
//  ActivityStreamItem.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityStreamActor.h"
#import "ActivityStreamObject.h"
#import "ActivityStreamTarget.h"

@interface ActivityStreamItem : NSObject {
    NSString* id;
    NSDate* postedTime;
    ActivityStreamActor* actor;
    NSString* verb;
    ActivityStreamObject* object;
    ActivityStreamTarget* target;
}

+ (NSArray*) arrayFromJSONString:(NSString*)jsonString;

@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSDate* postedTime;
@property (nonatomic, retain) ActivityStreamActor* actor;
@property (nonatomic, retain) NSString* verb;
@property (nonatomic, retain) ActivityStreamObject* object;
@property (nonatomic, retain) ActivityStreamTarget* target;

@end
