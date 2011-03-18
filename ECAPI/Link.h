//
//  Link.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Link : NSObject {
    NSString* href;
    NSString* rel;
}

@property (nonatomic, retain) NSString* href;
@property (nonatomic, retain) NSString* rel;

@end
