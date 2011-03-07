//
//  ActivityStreamActor.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamActor.h"
#import "ECCoder.h"

@implementation ActivityStreamActor

@synthesize role;
@synthesize referenceId;
@synthesize id;
@synthesize title;
@synthesize objectType;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.role           = [coder decodeObjectForKey:@"role"];
        self.referenceId    = [coder decodeIntegerForKey:@"referenceId"];
        self.id             = [coder decodeObjectForKey:@"id"];
        self.title          = [coder decodeObjectForKey:@"title"];
        self.objectType     = [coder decodeObjectForKey:@"objectType"];
    }
	return self;
}

- (void) dealloc {
    self.role = nil;
    self.id = nil;
    self.title = nil;
    self.objectType = nil;
    [super dealloc];
}


@end
