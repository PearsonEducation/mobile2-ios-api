//
//  ContainerInfo.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/19/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContainerInfo : NSObject

@property (nonatomic, retain) NSNumber *contentItemId;
@property (nonatomic, assign) NSInteger contentItemOrderNumber;
@property (nonatomic, retain) NSNumber* unitNumber;
@property (nonatomic, retain) NSNumber* courseId;
@property (nonatomic, retain) NSString* courseTitle;
@property (nonatomic, retain) NSString* contentItemTitle;
@property (nonatomic, retain) NSString* unitTitle;
@property (nonatomic, retain) NSString* unitHeader;

@end
