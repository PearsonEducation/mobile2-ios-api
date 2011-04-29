//
//  DropboxBasket.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DropboxBasket.h"
#import "Link.h"
#import "ECCoder.h"

@implementation DropboxBasket

@synthesize dropboxBasketId;
@synthesize title;
@synthesize links;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.dropboxBasketId    = [coder decodeNumberForKey:@"id"];
        self.title              = [coder decodeObjectForKey:@"title"];
        self.links              = [coder decodeArrayForKey:@"links" ofType:[Link class]];
    }
    return self;
}

- (void)dealloc {
	self.dropboxBasketId = nil;
    self.title = nil;
    self.links = nil;
	[super dealloc];
}

@end
