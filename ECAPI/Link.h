//
//  Link.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECCoder.h"

@interface Link : NSObject {
    NSString *href;
    NSString *rel;
	NSString *title;
}

- (id) initWithCoder:(NSCoder<ECCoder> *)coder;

@property (nonatomic, copy) NSString* href;
@property (nonatomic, copy) NSString* rel;
@property (nonatomic, copy) NSString* title;

@end
