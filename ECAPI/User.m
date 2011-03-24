//
//  User.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "User.h"
#import "ECCoder.h"

@implementation User
@synthesize userId, userName, firstName, lastName, emailAddress, clientString;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.userId         = [coder decodeIntegerForKey:@"id"];
        self.userName       = [coder decodeObjectForKey:@"userName"];
        self.firstName      = [coder decodeObjectForKey:@"firstName"];
        self.lastName       = [coder decodeObjectForKey:@"lastName"];
        self.emailAddress   = [coder decodeObjectForKey:@"emailAddress"];
        self.clientString   = [coder decodeObjectForKey:@"clientString"];
    }
	return self;
}

- (NSString*)fullName {
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}

- (void) dealloc {
    self.userName = nil;
    self.firstName = nil;
    self.lastName = nil;
    self.emailAddress = nil;
    self.clientString = nil;
    [super dealloc];
}

@end
