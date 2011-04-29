//
//  ActivityStreamObject.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ActivityStreamObject.h"
#import "ECCoder.h"

@implementation ActivityStreamObject

@synthesize courseId;
@synthesize referenceId;
@synthesize id;
@synthesize title;
@synthesize summary;
@synthesize objectType;
@synthesize letterGrade;
@synthesize pointsAchieved;
@synthesize attachments;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.courseId       = [coder decodeNumberForKey:@"courseId"];
        self.referenceId    = [NSString stringWithFormat:@"%d", [coder decodeIntegerForKey:@"referenceId"]];
        self.id             = [coder decodeObjectForKey:@"id"];
        self.title          = [coder decodeObjectForKey:@"title"];
        self.summary        = [coder decodeObjectForKey:@"summary"];
        self.objectType     = [coder decodeObjectForKey:@"objectType"];
        self.letterGrade    = [coder decodeObjectForKey:@"letterGrade"];
        self.attachments    = [coder decodeObjectForKey:@"attachments"];
        self.pointsAchieved = [coder decodeNumberForKey:@"pointsAchieved"];
    }
	return self;
}

- (void) dealloc {
	self.courseId = nil;
    self.attachments = nil;
    self.referenceId = nil;
    self.id = nil;
    self.title = nil;
    self.summary = nil;
    self.objectType = nil;
    self.letterGrade = nil;
    self.pointsAchieved = nil;
	[super dealloc];
}

@end
