//
//  ECTokenFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECTokenFetcher.h"
#import "ECJSONUnarchiver.h"
#import "AccessToken.h"
#import "ECConstants.h"

@implementation ECTokenFetcher

- (void) fetchAccessTokenForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password {
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", clientId, @"client_id", [NSString stringWithFormat:@"%@\\%@", clientString, username], @"username", password, @"password", nil];
	[super postParams:params toURLFromString:[NSString stringWithFormat:@"%@/token", M_API_URL] withDeserializationSelector:@selector(deserializeToken:)];
}

- (void) fetchAccessGrantForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password {
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:clientString, @"clientString", clientId, @"client_id", username, @"userLogin", password, @"password", nil];
	[super postParams:params toURLFromString:[NSString stringWithFormat:@"%@/authorize/grant", M_API_URL] withDeserializationSelector:@selector(deserializeToken:)];
}

- (void) fetchAccessTokenWithAccessGrant:(NSString *)accessGrantToken {
	NSString *encodedGrantString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																				   NULL,
																				   (CFStringRef)accessGrantToken,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8);
	[super loadDataFromURLString:[NSString stringWithFormat:@"%@/authorize/token/?access_grant=%@", M_API_URL, encodedGrantString] withDeserializationSelector:@selector(deserializeToken:)];
}

- (id) deserializeToken:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
	return [[[AccessToken alloc] initWithCoder:unarchiver] autorelease];
}

@end
