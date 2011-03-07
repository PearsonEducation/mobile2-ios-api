//
//  ActivityStreamTarget.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamTarget.h"
#import "ECCoder.h"


@implementation ActivityStreamTarget

@synthesize courseId;
@synthesize referenceId;
@synthesize id;
@synthesize title;
@synthesize summary;
@synthesize objectType;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.courseId       = [coder decodeIntegerForKey:@"courseId"];
        self.referenceId    = [coder decodeIntegerForKey:@"referenceId"];
        self.id             = [coder decodeObjectForKey:@"id"];
        self.title          = [coder decodeObjectForKey:@"title"];
        self.summary        = [coder decodeObjectForKey:@"summary"];
        self.objectType     = [coder decodeObjectForKey:@"objectType"];
    }
	return self;
}

- (void) dealloc {
    self.id = nil;
    self.title = nil;
    self.summary = nil;
    self.objectType = nil;
}


@end
