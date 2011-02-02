//
//  ECAuthenticatedFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECAuthenticatedFetcher.h"
#import "ECSession.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface ECAuthenticatedFetcher (PrivateMethods)
+ (void) setCommonHeadersForAuthenticatedRequest:(ASIHTTPRequest *)request;
@end

@implementation ECAuthenticatedFetcher

#pragma mark -
#pragma mark Request Constructors

+ (ASIHTTPRequest *) newAuthenticatedGETRequestWithURL:(NSURL *)earl {
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:earl]; // retain count +1
	[ECAuthenticatedFetcher setCommonHeadersForAuthenticatedRequest:request];
	return request;
}

+ (ASIFormDataRequest *) newAuthenticatedPOSTRequestWithURL:(NSURL *)earl {
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:earl]; // retain count +1
	[ECAuthenticatedFetcher setCommonHeadersForAuthenticatedRequest:request];
	return request;
}

+ (void) setCommonHeadersForAuthenticatedRequest:(ASIHTTPRequest *)request {
	[request setUseCookiePersistence:NO];
	[request addRequestHeader:@"Accept" value:@"application/json"];
	
	//TODO: Throw an error if session is not authenticated?
	ECSession *session = [ECSession sharedSession];
	NSString *accessTokenHeaderValue = [NSString stringWithFormat:@"Access_Token access_token=%@", session.accessToken];
	[request addRequestHeader:@"X-Authorization" value:accessTokenHeaderValue];
}

#pragma mark -
#pragma mark Setup and Teardown

- (id) initWithDelegate:(id)del responseSelector:(SEL)rcb errorSelector:(SEL)ecb {
	if (self = [super init]) {
		delegate = del; // weak reference
		responseCallback = rcb;
		errorCallback = ecb;
	}
	return self;
}

-(void) dealloc {
	[request release]; request = nil;
	[data release]; data = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Git R Dun

- (void) loadDataFromURLString:(NSString *)urlString {
	NSURL *earl = [NSURL URLWithString:urlString];
	
	request = [ECAuthenticatedFetcher newAuthenticatedGETRequestWithURL:earl];
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void) postParams:(NSDictionary *)params toURLFromString:(NSString *)urlString {
	NSURL *earl = [NSURL URLWithString:urlString];
	ASIFormDataRequest *formRequest = [ECAuthenticatedFetcher newAuthenticatedPOSTRequestWithURL:earl];
	
	for (id key in params) {
		[formRequest setPostValue:[params objectForKey:key] forKey:key];
	}
	
	request = formRequest;
	[request setDelegate:self];
	[request startAsynchronous];
}

- (void) dataDidFinishLoading {
	// abstract
}

- (void) informDelegateOfSuccess:(id)object {
	[delegate performSelector:responseCallback withObject:object];
}

- (void) cancel {
	[request cancel];
}

#pragma mark -
#pragma mark ASIHTTPRequest Callbacks

- (void)requestFinished:(ASIHTTPRequest *)aRequest {
	data = [[aRequest responseData] mutableCopy]; // retain count of +1
	[request release]; request = nil;
	[self dataDidFinishLoading];
}

- (void)requestFailed:(ASIHTTPRequest *)aRequest {
	[request release]; request = nil;
	if ([aRequest responseStatusCode] == 401 && [delegate respondsToSelector:@selector(authenticationFailed)]) {
		[delegate performSelector:@selector(authenticationFailed)];
	} else {
		[delegate performSelector:errorCallback];
	}
}

@end
