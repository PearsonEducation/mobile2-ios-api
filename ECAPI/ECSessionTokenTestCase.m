//
//  ECSessionTokenTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "AccessToken.h"
#import "ECSession.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface ECSessionTokenTestCase : GHTestCase { }
@end

@implementation ECSessionTokenTestCase

- (void) setUp {
	[[ECSession sharedSession] forgetCredentials];
}

- (void) testLoadAccessToken {
	ECSession *session = [ECSession sharedSession];
	GHAssertFalse([session hasActiveGrantToken], @"Expected session to not start from scratch and have an unexpired token");
	
	NSDictionary *expiredTokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate dateWithTimeIntervalSinceNow:-3600.0], @"expiresAt", @"oid303in30i3hn30ihn3", @"accessToken", nil];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:expiredTokenDictionary forKey:@"currentGrantToken"];
	[defaults synchronize];
	GHAssertFalse([session hasActiveGrantToken], @"Expected session to not have an unexpired token after an expired one is persisted");

	[session forgetCredentials];
	NSDictionary *unexpiredTokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate dateWithTimeIntervalSinceNow:3600.0], @"expiresAt", @"oid303in30i3hn30ihn3", @"accessToken", nil];
	
	[defaults setObject:unexpiredTokenDictionary forKey:@"currentGrantToken"];
	[defaults synchronize];
	GHAssertTrue([session hasActiveGrantToken], @"Expected session to have an unexpired token after an unexpired one is persisted");
}

@end
