//
//  AccessGrantTestCase.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "AccessToken.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"

@interface AccessTokenTestCase : GHTestCase { }
@end

@implementation AccessTokenTestCase

- (void) testDeserializeAccessGrantFromJSON {
	NSString *accessGrantJSON = @"{\"access_token\":\"30bb1d4f-2677-45d1-be13-339174404402|ee5397b0-9051-4f35-8f0f-8d7ab7b15921|4822784|2011-08-24T13%3a16%3a25|32dd52447a07733f2b6307d345c31c21\",\"expires_in\":15552000}";
	SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
	NSDictionary *grantDictionary = (NSDictionary *)[parser objectWithString:accessGrantJSON];
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:grantDictionary];
    
	AccessToken *grant = [[[AccessToken alloc] initWithCoder:unarchiver] autorelease];
	GHAssertEqualObjects(grant.accessToken, @"30bb1d4f-2677-45d1-be13-339174404402|ee5397b0-9051-4f35-8f0f-8d7ab7b15921|4822784|2011-08-24T13%3a16%3a25|32dd52447a07733f2b6307d345c31c21", @"Expected accessGrant to equal 30bb1d4f-2677-45d1-be13-339174404402|ee5397b0-9051-4f35-8f0f-8d7ab7b15921|4822784|2011-08-24T13%3a16%3a25|32dd52447a07733f2b6307d345c31c21");
	NSDate *oneEightyDaysFromNow = [NSDate dateWithTimeIntervalSinceNow:(180 * 24 * 60 * 60)];
	GHAssertEqualsWithAccuracy([grant.expiresAt timeIntervalSince1970], [oneEightyDaysFromNow timeIntervalSince1970], 1, @"Expected expire date to be 180 days out");
}

- (void) testExpired {
	NSDictionary *expiredTokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate dateWithTimeIntervalSinceNow:-3600.0], @"expiresAt", nil];    
	AccessToken *expiredGrant = [[[AccessToken alloc] initWithDictionary:expiredTokenDictionary] autorelease];
	GHAssertTrue([expiredGrant isExpired], @"expected expired dictionary to produce a token that is expired");

	NSDictionary *unexpiredTokenDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSDate dateWithTimeIntervalSinceNow:3600.0], @"expiresAt", nil];    
	AccessToken *unexpiredGrant = [[[AccessToken alloc] initWithDictionary:unexpiredTokenDictionary] autorelease];
	GHAssertFalse([unexpiredGrant isExpired], @"expected unexpired dictionary to produce a token that is unexpired");
}

@end