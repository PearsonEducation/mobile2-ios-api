//
//  UserDiscussionTopic.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserDiscussionTopic.h"
#import "ECCoder.h"

@implementation UserDiscussionTopic

@synthesize userDiscussionTopicId;
@synthesize topic;
@synthesize childResponseCounts;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.userDiscussionTopicId          = [NSString stringWithFormat:@"%@",[coder decodeObjectForKey:@"topic"]];
        self.topic                          = [coder decodeObjectForKey:@"topic" ofType:[DiscussionTopic class]];
        self.childResponseCounts            = [coder decodeObjectForKey:@"childResponseCounts" ofType:[ResponseCount class]];
    }
	return self;
}

- (void)dealloc {
    self.userDiscussionTopicId = nil;
    self.topic = nil;
    self.childResponseCounts = nil;
    [super dealloc];
}

@end
