//
//  ResponseCount.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerInfo.h"

@interface ResponseCount : NSObject {
    NSInteger totalResponseCount;
    NSInteger unreadResponseCount;
    NSInteger personalResponseCount;
    NSInteger last24HourResponseCount;
}

@property (nonatomic, assign) NSInteger totalResponseCount;
@property (nonatomic, assign) NSInteger unreadResponseCount;
@property (nonatomic, assign) NSInteger personalResponseCount;
@property (nonatomic, assign) NSInteger last24HourResponseCount;

@end
