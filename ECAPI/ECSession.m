//
//  ECSession.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation ECSession
@synthesize authenticationDelegate, clientString, username, accessToken;

- (id) initWithClientString:(NSString *)cs username:(NSString *)un password:(NSString *)pw {
	if (self == [super init]) {
		clientString = cs;
		username = un;
		_password = [pw retain];
	}
	return self;
}

- (void) dealloc {
	self.authenticationDelegate = nil;
	[clientString release]; clientString = nil;
	[username release]; username = nil;
	[accessToken release]; accessToken = nil;
	[_password release]; _password = nil;
	[authenticationRequest release]; authenticationRequest = nil;
}

- (void) authenticate {
	authenticationRequest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:M_API_URL]];
	authenticationRequest.delegate = self;
	[authenticationRequest startAsynchronous];
}

#pragma mark -
#pragma mark ASIHTTPRequest Callbacks

- (void)requestFinished:(ASIHTTPRequest *)aRequest {
	NSData *data = [[[aRequest responseData] mutableCopy] autorelease];
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	SBJsonParser *sbjson = [[SBJsonParser alloc] init];
	// TODO: handle errors
	NSDictionary *responseDictionary = (NSDictionary *)[sbjson objectWithString:jsonString error:NULL];
	accessToken = [responseDictionary objectForKey:@"access_token"];

	[authenticationRequest release]; authenticationRequest = nil;
	[self.authenticationDelegate sessionDidAuthenticate:self];
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest {
	[authenticationRequest release]; authenticationRequest = nil;
	// Handle error
}


@end
