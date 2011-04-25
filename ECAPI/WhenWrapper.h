//
//  WhenWrapper.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/22/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WhenWrapper : NSObject {
    NSDate* time;
}

@property (nonatomic, retain) NSDate* time;

@end
