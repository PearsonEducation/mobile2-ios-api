//
//  TestingTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "TestingTestCase.h"


@implementation TestingTestCase

- (void) testSimpleMath {
	STAssertEquals(1,1, @"Math fails");
}

@end
