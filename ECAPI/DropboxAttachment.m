//
//  DropboxAttachment.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DropboxAttachment.h"
#import "ECCoder.h"

@implementation DropboxAttachment

@synthesize dropboxMessageId;
@synthesize name;
@synthesize contentUrl;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
    if ((self == [super init])) {
        self.dropboxMessageId       = [coder decodeIntegerForKey:@"id"];
        self.name                   = [coder decodeObjectForKey:@"name"];
        self.contentUrl             = [coder decodeObjectForKey:@"contentUrl"];
    }
    return self;
}

- (void)dealloc {
    self.name = nil;
    self.contentUrl = nil;
    [super dealloc];
}

@end