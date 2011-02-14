//
//  GradeDeserializationTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/11/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Grade.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface GradeDeserializationTestCase : GHTestCase { }
@end

@implementation GradeDeserializationTestCase

- (void) testDeserializeGradeFromJSON {
	NSString *gradeJson = @"{\"average\":4.0,\"earned\":4.00,\"possible\":20.0,\"extraCredit\":0.0,\"isWeightingOn\":false,\"letterGrade\":{\"letterGrade\":\"A\",\"comments\":\"\"},\"shareWithStudent\":true}";
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
	NSDictionary *gradeDictionary = (NSDictionary *)[[parser objectWithString:gradeJson] retain];
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:gradeDictionary];
	Grade *grade = [[[Grade alloc] initWithCoder:unarchiver] autorelease];
	GHAssertEqualsWithAccuracy(4.0f, grade.average, 0.0f, @"Expecting average grade to be 4.0");
	GHAssertEqualsWithAccuracy(4.0f, grade.earned, 0.0f, @"Expecting earned to be 4.0");
	GHAssertEqualsWithAccuracy(20.0f, grade.possible, 0.0f, @"Expecting possible to be 20.0");
	GHAssertEqualsWithAccuracy(0.0f, grade.extraCredit, 0.0f, @"Expecting extra credit to be 0.0");
	GHAssertFalse(grade.isWeightingOn, @"Expecting weighting to be off");
	GHAssertEqualStrings(@"A", grade.letterGrade, @"Expecting letter grade to be an 'A'");
	GHAssertEqualObjects(nil, grade.letterGradeComments, @"Expecting letter grade comments to be nil");
}

@end