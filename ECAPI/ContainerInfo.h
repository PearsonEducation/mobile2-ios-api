//
//  ContainerInfo.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/19/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContainerInfo : NSObject {
    NSInteger contentItemId;
    NSInteger contentItemOrderNumber;
    NSInteger unitNumber;
    NSInteger courseId;
    NSString* courseTitle;
    NSString* contentItemTitle;
    NSString* unitTitle;
    NSString* unitHeader;
}

@property (nonatomic, assign) NSInteger contentItemId;
@property (nonatomic, assign) NSInteger contentItemOrderNumber;
@property (nonatomic, assign) NSInteger unitNumber;
@property (nonatomic, assign) NSInteger courseId;
@property (nonatomic, retain) NSString* courseTitle;
@property (nonatomic, retain) NSString* contentItemTitle;
@property (nonatomic, retain) NSString* unitTitle;
@property (nonatomic, retain) NSString* unitHeader;

@end
