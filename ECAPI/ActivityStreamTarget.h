//
//  ActivityStreamTarget.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityStreamTarget : NSObject {
    NSInteger courseId;
    NSInteger referenceId;
    NSString* id;
    NSString* title;
    NSString* summary;
    NSString* objectType;
}

@property (nonatomic, assign) NSInteger courseId;
@property (nonatomic, assign) NSInteger referenceId;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* summary;
@property (nonatomic, retain) NSString* objectType;

@end
