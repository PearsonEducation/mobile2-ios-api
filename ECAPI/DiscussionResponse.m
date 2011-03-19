//
//  DiscussionResponse.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DiscussionResponse.h"
#import "ECCoder.h"

@implementation DiscussionResponse

@synthesize discussionResponseId;
@synthesize title;
@synthesize description;
@synthesize author;
@synthesize postedDate;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.discussionResponseId   = [coder decodeIntegerForKey:@"id"];
        self.title                  = [coder decodeObjectForKey:@"title"];
        self.description            = [coder decodeObjectForKey:@"description"];
        self.author                 = [coder decodeObjectForKey:@"author" ofType:[User class]];
        self.postedDate             = [coder decodeDateForKey:@"postedDate"];
    }
	return self;
}

- (void)dealloc {
    self.title = nil;
    self.description = nil;
    self.author = nil;
    self.postedDate = nil;
    [super dealloc];
}

@end
