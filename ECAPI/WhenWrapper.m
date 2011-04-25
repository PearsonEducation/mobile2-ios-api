//
//  WhenWrapper.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/22/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "WhenWrapper.h"
#import "ECCoder.h"

@implementation WhenWrapper

@synthesize time;

- (id) initWithCoder:(NSCoder<ECCoder>*)coder {
    self = [super init];
	if (self) {
        self.time = [coder decodeDateForKey:@"time"];
    }
    return self;
}

- (void)dealloc {
    self.time = nil;
    [super dealloc];
}

@end
