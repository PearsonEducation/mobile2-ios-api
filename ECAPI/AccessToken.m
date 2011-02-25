//
//  AccessGrant.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "AccessToken.h"
#import "ECCoder.h"

@implementation AccessToken
@synthesize expiresAt, accessToken, refreshToken;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.accessToken    = [coder decodeObjectForKey:@"access_token"];
        self.refreshToken   = [coder decodeObjectForKey:@"refresh_token"];
        NSInteger expiresIn = [coder decodeIntegerForKey:@"expires_in"];
		self.expiresAt = [NSDate dateWithTimeInterval:expiresIn sinceDate:[NSDate date]];
    }
	return self;
}


@end
