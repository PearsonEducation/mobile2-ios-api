//
//  GradebookItemGrade.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Grade : NSObject {
    NSInteger gradeId;
    NSDecimalNumber* points;
    NSString* letterGrade;
    NSString* comments;
    NSDate* updatedDate;
}

@property (nonatomic, assign) NSInteger gradeId;
@property (nonatomic, retain) NSDecimalNumber* points;
@property (nonatomic, retain) NSString* letterGrade;
@property (nonatomic, retain) NSString* comments;
@property (nonatomic, retain) NSDate* updatedDate;

@end
