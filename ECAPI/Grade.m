//
//  GradebookItemGrade.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Grade.h"
#import "ECCoder.h"

@implementation Grade

@synthesize gradeId;
@synthesize points;
@synthesize letterGrade;
@synthesize comments;
@synthesize updatedDate;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.gradeId       = [coder decodeIntegerForKey:@"id"];
        self.points                 = [coder decodeNumberForKey:@"points"];
        self.letterGrade            = [coder decodeObjectForKey:@"letterGrade"];
        self.comments               = [coder decodeObjectForKey:@"comments"];
        self.updatedDate            = [coder decodeDateForKey:@"updatedDate"];
    }
	return self;
}

- (BOOL) isGraded {
	return (self.updatedDate != nil);
}

- (void)dealloc {
    self.points = nil;
    self.letterGrade = nil;
    self.comments = nil;
    self.updatedDate = nil;
    [super dealloc];
}

@end
