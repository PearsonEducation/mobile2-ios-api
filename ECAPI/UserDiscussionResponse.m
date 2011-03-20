//
//  UserDiscussionResponse.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserDiscussionResponse.h"
#import "ECCoder.h"

@implementation UserDiscussionResponse

@synthesize userDiscussionResponseId;
@synthesize markedAsRead;
@synthesize response;
@synthesize childResponseCounts;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.userDiscussionResponseId         = [coder decodeIntegerForKey:@"id"];
        self.markedAsRead                     = [coder decodeBoolForKey:@"markedAsRead"];
        self.response                         = [coder decodeObjectForKey:@"response" ofType:[DiscussionResponse class]];
        self.childResponseCounts              = [coder decodeObjectForKey:@"childResponseCounts" ofType:[ResponseCount class]];
    }
	return self;
}

- (void)dealloc {
    self.response = nil;
    self.childResponseCounts = nil;
    [super dealloc];
}

@end
