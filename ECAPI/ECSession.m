//
//  ECSession.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@interface ECSession (Private)
- (void) forgetCredentials;
@end


@implementation ECSession
static ECSession *sharedSession = nil;
@synthesize authenticationDelegate, clientString, username, accessToken;

#pragma mark -
#pragma mark Singleton Implementation

+ (ECSession *) sharedSession {
	if (sharedSession == nil) {
		sharedSession = [[super allocWithZone:NULL] init];
	}
	return sharedSession;
}

+ (id) allocWithZone:(NSZone *)zone {
	return [[self sharedSession] retain];
}

- (id) copyWithZone:(NSZone *)zone {
	return self;
}

- (id) retain {
    return self;
}

- (NSUInteger) retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void) release {
    //do nothing -> singleton
}

- (id) autorelease {
    return self;
}

#pragma mark -
#pragma mark Shared Session Implementation

- (void) dealloc {
	[self forgetCredentials];
	self.authenticationDelegate = nil;
	[authenticationRequest release]; authenticationRequest = nil;
	[super dealloc];
}

- (void) authenticateWithClientId:(NSString *)cid clientString:(NSString *)cs username:(NSString *)un password:(NSString *)pw {
	[self forgetCredentials];
	clientId = [cid retain];
	clientString = [cs retain];
	username = [un retain];
	_password = [pw retain];
	authenticationRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/token", M_API_URL]]];
	[authenticationRequest addRequestHeader:@"Accept" value:@"application/json"];
	[authenticationRequest setPostValue:@"password" forKey:@"grant_type"];
	[authenticationRequest setPostValue:_password forKey:@"password"];
	[authenticationRequest setPostValue:[NSString stringWithFormat:@"%@\\%@", clientString, username] forKey:@"username"];
	[authenticationRequest setPostValue:clientId forKey:@"client_id"];
	
	authenticationRequest.delegate = self;
	[authenticationRequest startAsynchronous];
}

- (BOOL) isAuthenticated {
	return (accessToken != nil);
}

- (void) forgetCredentials {
	[clientId release]; clientId = nil;
	[clientString release]; clientString = nil;
	[username release]; username = nil;
	[accessToken release]; accessToken = nil;
	[_password release]; _password = nil;
}

#pragma mark -
#pragma mark ASIHTTPRequest Callbacks

- (void)requestFinished:(ASIHTTPRequest *)aRequest {
	NSData *data = [[[aRequest responseData] mutableCopy] autorelease];
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *sbjson = [[SBJsonParser alloc] init];
	// TODO: handle errors
	NSDictionary *responseDictionary = (NSDictionary *)[sbjson objectWithString:jsonString error:NULL];
	accessToken = [[responseDictionary objectForKey:@"access_token"] copy];

	[authenticationRequest release]; authenticationRequest = nil;
	[self.authenticationDelegate sessionDidAuthenticate:self];
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest {
	[authenticationRequest release]; authenticationRequest = nil;
	// Handle error
}


@end
