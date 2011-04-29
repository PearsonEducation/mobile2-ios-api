//
//  ActivityStreamObject.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityStreamObject : NSObject {
    NSNumber* courseId;
    NSString* referenceId;
    NSString* id;
    NSString* title;
    NSString* summary;
    NSString* objectType;
    NSString* letterGrade;
    NSArray* attachments;
    NSDecimalNumber* pointsAchieved;
}

@property (nonatomic, retain) NSNumber* courseId;
@property (nonatomic, retain) NSString* referenceId;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* summary;
@property (nonatomic, retain) NSString* objectType;
@property (nonatomic, retain) NSString* letterGrade;
@property (nonatomic, retain) NSArray* attachments;
@property (nonatomic, retain) NSDecimalNumber* pointsAchieved;

@end
