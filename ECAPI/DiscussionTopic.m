//
//  DiscussionTopic.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DiscussionTopic.h"
#import "ECCoder.h"

@implementation DiscussionTopic

@synthesize discussionTopicId;
@synthesize title;
@synthesize description;
@synthesize orderNumber;
@synthesize containerInfo;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.discussionTopicId   = [coder decodeIntegerForKey:@"discussionTopicId"];
        self.title               = [coder decodeObjectForKey:@"title"];
        self.description         = [coder decodeObjectForKey:@"description"];
        self.orderNumber         = [coder decodeIntegerForKey:@"orderNumber"];
        self.containerInfo       = [coder decodeObjectForKey:@"containerInfo" ofType:[ContainerInfo class]];
    }
	return self;
}

- (void)dealloc {
    self.title = nil;
    self.description = nil;
    self.containerInfo = nil;
    [super dealloc];
}

@end
