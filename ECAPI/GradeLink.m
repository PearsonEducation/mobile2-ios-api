//
//  GradeLink.m
//  ECAPI
//
//  Created by Tony Hillerson on 4/5/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "GradeLink.h"
#import "Grade.h"
#import "ECCoder.h"

@implementation GradeLink
@synthesize grade;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super initWithCoder:coder])) {
        self.grade = [coder decodeObjectForKey:@"grade" ofType:[Grade class]];
    }
	return self;
}

- (void)dealloc {
    self.grade = nil;
}


@end
