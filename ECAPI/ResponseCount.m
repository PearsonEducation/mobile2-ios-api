//
//  ResponseCount.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ResponseCount.h"
#import "ECCoder.h"

@implementation ResponseCount

@synthesize totalResponseCount;
@synthesize unreadResponseCount;
@synthesize personalResponseCount;
@synthesize last24HourResponseCount;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.totalResponseCount         = [coder decodeIntegerForKey:@"totalResponseCount"];
        self.unreadResponseCount        = [coder decodeIntegerForKey:@"unreadResponseCount"];
        self.personalResponseCount      = [coder decodeIntegerForKey:@"personalResponseCount"];
        self.last24HourResponseCount    = [coder decodeIntegerForKey:@"last24HourResponseCount"];
    }
	return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
