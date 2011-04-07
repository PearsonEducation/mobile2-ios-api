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
#import "ASIHTTPRequest.h"

@interface ECTokenFetcher (Private)
- (id) deserializeToken:(id)parsedData;
@end

@implementation ECTokenFetcher

- (void) fetchAccessTokenForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password {
	self.ignoreAuthentication = YES;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"password", @"grant_type", clientId, @"client_id", [NSString stringWithFormat:@"%@\\%@", clientString, username], @"username", password, @"password", nil];
	[super postParams:params toURLFromString:[NSString stringWithFormat:@"%@/token", M_API_URL] withDeserializationSelector:@selector(deserializeToken:)];
}

- (void) fetchAccessGrantForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password {
	self.ignoreAuthentication = YES;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:clientString, @"clientString", clientId, @"client_id", username, @"userLogin", password, @"password", nil];
	[super postParams:params toURLFromString:[NSString stringWithFormat:@"%@/authorize/grant", M_API_URL] withDeserializationSelector:@selector(deserializeToken:)];
}

- (void) fetchAccessTokenWithAccessGrant:(NSString *)accessGrantToken {
	self.ignoreAuthentication = YES;
	NSString *encodedGrantString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																					   NULL,
																					   (CFStringRef)accessGrantToken,
																					   NULL,
																					   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																					   kCFStringEncodingUTF8);
	[super loadDataFromURLString:[NSString stringWithFormat:@"%@/authorize/token/?access_grant=%@", M_API_URL, encodedGrantString] withDeserializationSelector:@selector(deserializeToken:)];
	[encodedGrantString release];
}

- (id) syncronousFetchAccessTokenWithAccessGrant:(NSString *)accessGrantToken {
	NSString *encodedGrantString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																					   NULL,
																					   (CFStringRef)accessGrantToken,
																					   NULL,
																					   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																					   kCFStringEncodingUTF8);
	NSString *earl = [NSString stringWithFormat:@"%@/authorize/token/?access_grant=%@", M_API_URL, encodedGrantString];
	[encodedGrantString release];
	NSURL *url = [NSURL URLWithString:earl];
	ASIHTTPRequest *tokenRequest = [[ASIHTTPRequest alloc] initWithURL:url];
	
	[tokenRequest startSynchronous];
    NSError *error = [tokenRequest error];
	AccessToken *token = nil;
    if (error) {
		[tokenRequest release]; tokenRequest = nil;
        return error;
    } else {
        data = [[tokenRequest responseData] mutableCopy]; // retain count of +1
		NSDictionary *parsedDictionary = (NSDictionary *)[self parseReturnedData];
		[tokenRequest release]; tokenRequest = nil;
		if ([parsedDictionary isKindOfClass:[NSError class]]) {
			return parsedDictionary;
		}
        token = (AccessToken *)[self deserializeToken:parsedDictionary];
    }
	return token;
}

- (id) deserializeToken:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
	return [[[AccessToken alloc] initWithCoder:unarchiver] autorelease];
}

@end
