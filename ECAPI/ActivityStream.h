//
//  ActivityStream.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/7/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ActivityStream : NSObject {
    NSString* title;
    NSArray* items;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSArray* items;

@end
