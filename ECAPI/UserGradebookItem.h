
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
    NSInteger userGradebookItemId;
	NSArray *gradeLinks;
    GradebookItem *gradebookItem;
}

@property (nonatomic, assign) NSInteger userGradebookItemId;
@property (nonatomic, retain) GradebookItem *gradebookItem;
@property (nonatomic, retain) NSArray *gradeLinks;

- (Grade *) grade;

@end
