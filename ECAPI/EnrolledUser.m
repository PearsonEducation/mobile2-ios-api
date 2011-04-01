//
//  EnrolledUser.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "EnrolledUser.h"
#import "ECCoder.h"

@implementation EnrolledUser

@synthesize enrolledUserId;
@synthesize enrollmentDate;
@synthesize user;
@synthesize role;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.enrolledUserId         = [coder decodeIntegerForKey:@"id"];
        self.enrollmentDate         = [coder decodeDateForKey:@"enrollmentDate"];
        self.user                   = [coder decodeObjectForKey:@"user" ofType:[User class]];
        self.role                   = [coder decodeObjectForKey:@"role" ofType:[Role class]];
    }
	return self;
}

- (void)dealloc {
    self.enrollmentDate = nil;
    self.user = nil;
    self.role = nil;
}

@end
