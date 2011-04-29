//
//  ActivityStreamActor.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityStreamActor : NSObject {
    NSString* role;
    NSNumber* referenceId;
    NSString* id;
    NSString* title;
    NSString* objectType;
}

@property (nonatomic, retain) NSString* role;
@property (nonatomic, retain) NSNumber* referenceId;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* objectType;

@end
