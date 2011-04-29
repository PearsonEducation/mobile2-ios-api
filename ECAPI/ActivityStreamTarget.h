//
//  ActivityStreamTarget.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityStreamTarget : NSObject {
    NSNumber* courseId;
    NSDecimalNumber* pointsPossible;
    NSString* referenceId;
    NSString* id;
    NSString* title;
    NSString* summary;
    NSString* objectType;
}

@property (nonatomic, retain) NSNumber* courseId;
@property (nonatomic, retain) NSString* referenceId;
@property (nonatomic, retain) NSDecimalNumber* pointsPossible;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* summary;
@property (nonatomic, retain) NSString* objectType;

@end
