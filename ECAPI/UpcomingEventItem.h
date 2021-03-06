//
//  UpcomingEventItem.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/21/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WhenWrapper.h"

typedef enum {
	QuizExamTest,
	Thread,
	Html,
    Ignored
} UpcomingEventType;

typedef enum {
	Start,
	End,
	Due
} CategoryType;

@interface UpcomingEventItem : NSObject {
    NSString* dateString;
    
    WhenWrapper* when;
    NSNumber *upcomingEventItemId;
    NSString* type;
    NSString* title;
    NSString* category;
    NSArray* links;
    
    NSNumber *_courseId;
    CategoryType _cat;
    UpcomingEventType _uet;
}

@property (nonatomic, retain) WhenWrapper* when;
@property (nonatomic, retain) NSNumber *upcomingEventItemId;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* dateString;
@property (nonatomic, retain) NSString* category;
@property (nonatomic, retain) NSArray* links;
@property (nonatomic, readonly) NSNumber *courseId;
@property (nonatomic, readonly) NSNumber *threadId;
@property (nonatomic, readonly) NSNumber *multimediaId;
@property (nonatomic, readonly) CategoryType categoryType;
@property (nonatomic, readonly) UpcomingEventType eventType;

@end
