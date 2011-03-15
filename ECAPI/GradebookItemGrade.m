//
//  GradebookItemGrade.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "GradebookItemGrade.h"
#import "ECCoder.h"

@implementation GradebookItemGrade

@synthesize gradebookGradeId;
@synthesize points;
@synthesize letterGrade;
@synthesize comments;
@synthesize updatedDate;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.gradebookGradeId       = [coder decodeIntegerForKey:@"id"];
        self.points                 = [coder decodeNumberForKey:@"points"];
        self.letterGrade            = [coder decodeObjectForKey:@"letterGrade"];
        self.comments               = [coder decodeObjectForKey:@"comments"];
        self.updatedDate            = [coder decodeDateForKey:@"updatedDate"];
    }
	return self;
}

- (void)dealloc {
    self.points = nil;
    self.letterGrade = nil;
    self.comments = nil;
    self.updatedDate = nil;
    [super dealloc];
}

@end
