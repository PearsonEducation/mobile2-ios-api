//
//  ActivityStream.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/7/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStream.h"
#import "ECCoder.h"
#import "ActivityStreamItem.h"

@implementation ActivityStream

@synthesize title;
@synthesize items;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.title          = [coder decodeObjectForKey:@"title"];
        self.items    = [coder decodeArrayForKey:@"items" ofType:[ActivityStreamItem class]];
    }
	return self;
}

- (void) dealloc {
    self.title = nil;
    self.items = nil;
    [super dealloc];
}

@end
