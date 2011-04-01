//
//  GradebookItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "GradebookItem.h"
#import "ECCoder.h"

@implementation GradebookItem

@synthesize gradebookItemId;
@synthesize type;
@synthesize title;
@synthesize pointsPossible;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.gradebookItemId        = [coder decodeIntegerForKey:@"id"];
        self.type                   = [coder decodeObjectForKey:@"type"];
        self.title                  = [coder decodeObjectForKey:@"title"];
        self.pointsPossible         = [coder decodeNumberForKey:@"pointsPossible"];
    }
	return self;
}

- (void)dealloc {
    self.type = nil;
    self.title = nil;
    self.pointsPossible = nil;
}

@end
