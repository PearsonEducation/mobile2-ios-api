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

- (id) initWithDictionary:(NSDictionary *)dictionary {
	if ((self == [super init])) {
        self.accessToken	= [dictionary objectForKey:@"accessToken"];
        self.refreshToken	= [dictionary objectForKey:@"refreshToken"];
        self.expiresAt		= [dictionary objectForKey:@"expiresAt"];
    }
	return self;
}

- (void) saveInDictionary:(NSMutableDictionary *)dictionary {
	[dictionary setObject:self.accessToken forKey:@"accessToken"];
	if (self.refreshToken) {
		[dictionary setObject:self.refreshToken forKey:@"refreshToken"];
	}
	[dictionary setObject:self.expiresAt forKey:@"expiresAt"];
}

- (BOOL) isExpired {
	NSDate *now = [NSDate date];
	return ([now timeIntervalSince1970] >= [self.expiresAt timeIntervalSince1970]);
}

- (NSString *) description {
	return [NSString stringWithFormat:@"<AccessToken accessToken:%@ refreshToken:%@ expiresAt:%@>", self.accessToken, self.refreshToken, self.expiresAt];
}


@end
