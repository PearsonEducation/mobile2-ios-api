
//
//  UserGradebookItem.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GradebookItem.h"
#import "Grade.h"

@interface UserGradebookItem : NSObject {
    NSNumber *userGradebookItemId;
	NSArray *gradeLinks;
    GradebookItem *gradebookItem;
}

@property (nonatomic, retain) NSNumber *userGradebookItemId;
@property (nonatomic, retain) GradebookItem *gradebookItem;
@property (nonatomic, retain) NSArray *gradeLinks;

- (NSString*)numericGradeString;
- (NSString*)letterGradeString;
- (NSString*)displayedGrade;
- (Grade*)grade;

@end
