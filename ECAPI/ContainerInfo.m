//
//  ContainerInfo.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/19/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ContainerInfo.h"
#import "ECCoder.h"


@implementation ContainerInfo

@synthesize contentItemId;
@synthesize contentItemOrderNumber;
@synthesize unitNumber;
@synthesize courseId;
@synthesize courseTitle;
@synthesize contentItemTitle;
@synthesize unitTitle;
@synthesize unitHeader;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.contentItemId              = [coder decodeObjectForKey:@"contentItemID"];
        self.contentItemOrderNumber     = [coder decodeIntegerForKey:@"contentItemOrderNumber"];
        self.unitNumber                 = [coder decodeNumberForKey:@"unitNumber"];
        self.courseId                   = [coder decodeNumberForKey:@"courseID"];
        self.courseTitle                = [coder decodeObjectForKey:@"courseTitle"];
        self.contentItemTitle           = [coder decodeObjectForKey:@"contentItemTitle"];
        self.unitTitle                  = [coder decodeObjectForKey:@"unitTitle"];
        self.unitHeader                 = [coder decodeObjectForKey:@"unitHeader"];
    }
	return self;
}

- (void)dealloc {
	self.contentItemId = nil;
	self.courseId = nil;
	self.unitNumber = nil;
    self.courseTitle = nil;
    self.contentItemTitle = nil;
    self.unitTitle = nil;
    self.unitHeader = nil;
    [super dealloc];
}


@end
