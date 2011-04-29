//
//  Role.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Role.h"
#import "ECCoder.h"

@implementation Role

@synthesize roleId;
@synthesize type;
@synthesize name;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.roleId                 = [coder decodeNumberForKey:@"id"];
        self.type                   = [coder decodeObjectForKey:@"type"];
        self.name                   = [coder decodeObjectForKey:@"name"];
    }
	return self;
}

- (void)dealloc {
	self.roleId = nil;
    self.type = nil;
    self.name = nil;
	[super dealloc];
}

@end
