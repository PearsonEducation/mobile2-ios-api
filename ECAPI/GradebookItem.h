
//
//  GradebookItem.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GradebookItem : NSObject {
    NSNumber* gradebookItemId;
    NSString* type;
    NSString* title;
    NSDecimalNumber* pointsPossible;
}

@property (nonatomic, retain) NSNumber* gradebookItemId;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSDecimalNumber* pointsPossible;

@end
