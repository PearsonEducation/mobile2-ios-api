//
//  Link.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Link.h"
#import "ECCoder.h"

@implementation Link
@synthesize href, rel, title;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.href		= [coder decodeObjectForKey:@"href"];
        self.rel        = [coder decodeObjectForKey:@"rel"];
		self.title		= [coder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)dealloc {
    self.href = nil;
    self.rel = nil;
	self.title = nil;
}

@end
