//
//  ActivityStreamItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamItem.h"
#import "ECCoder.h"

@implementation ActivityStreamItem

@synthesize id;
@synthesize postedTime;
@synthesize actor;
@synthesize verb;
@synthesize object;
@synthesize target;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.id             = [coder decodeObjectForKey:@"id"];
        self.postedTime     = [coder decodeDateForKey:@"postedTime"];
        self.actor          = [coder decodeObjectForKey:@"actor" ofType:[ActivityStreamActor class]];
        self.verb           = [coder decodeObjectForKey:@"verb"];
        self.object         = [coder decodeObjectForKey:@"object" ofType:[ActivityStreamObject class]];
        self.target         = [coder decodeObjectForKey:@"target" ofType:[ActivityStreamTarget class]];
    }
	return self;
}

- (void) dealloc {
    self.id = nil;
    self.postedTime = nil;
    self.actor = nil;
    self.verb = nil;
    self.object = nil;
    self.target = nil;
    [super dealloc];
}

@end