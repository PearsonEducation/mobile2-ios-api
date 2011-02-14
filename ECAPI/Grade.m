//
//  Grade.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/11/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Grade.h"
#import "ECCoder.h"

@implementation Grade
@synthesize average, earned, possible, extraCredit, isWeightingOn, shareWithStudent, letterGrade, letterGradeComments;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self = [super init])) {
		self.average = [[coder decodeNumberForKey:@"average"] floatValue];
		self.earned = [[coder decodeNumberForKey:@"earned"] floatValue];
		self.possible = [[coder decodeNumberForKey:@"possible"] floatValue];
		self.extraCredit = [[coder decodeNumberForKey:@"extraCredit"] floatValue];
		self.isWeightingOn = [coder decodeBoolForKey:@"isWeightingOn"];
		self.shareWithStudent = [coder decodeBoolForKey:@"shareWithStudent"];
		NSDictionary *letterGradeDictionary = [coder decodeObjectForKey:@"letterGrade"];
		self.letterGrade = [letterGradeDictionary objectForKey:@"letterGrade"];
		self.letterGradeComments = [letterGradeDictionary objectForKey:@"letterGradeComments"];
	}
	return self;
}

- (void) dealloc {
	self.letterGrade = nil;
	self.letterGradeComments = nil;
}
@end
