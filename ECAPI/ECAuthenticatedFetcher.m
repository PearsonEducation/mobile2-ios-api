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
@synthesize responseHeaders, responseStatusCode;

#pragma mark -
#pragma mark Request Factory Methods

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

- (id) initWithDelegate:(id)del responseSelector:(SEL)rcb {
	if ((self = [super init])) {
		delegate = del; // weak reference
		responseCallback = rcb;
	}
	return self;
}

-(void) dealloc {
	self.responseHeaders = nil;
    [urlString release]; urlString = nil;
	[request release]; request = nil;
	[data release]; data = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Git R Dun

- (void) loadDataFromURLString:(NSString *)us {
    urlString = [us copy];
    [self performSelectorInBackground:@selector(loadDataInBackground) withObject:nil];
}

- (void) loadDataInBackground {
    autoreleasePool = [[NSAutoreleasePool alloc] init];
    NSURL *earl = [NSURL URLWithString:urlString];
	
	request = [ECAuthenticatedFetcher newAuthenticatedGETRequestWithURL:earl];
	[request startSynchronous];
    NSError *error = [request error];
    id returnedData = nil;
    if (error) {
        if ([request responseStatusCode] == 401 && [delegate respondsToSelector:@selector(authenticationFailed)]) {
            [delegate performSelectorOnMainThread:@selector(authenticationFailed) withObject:error waitUntilDone:NO];
        } else {
            [delegate performSelectorOnMainThread:responseCallback withObject:error waitUntilDone:NO];
        }
    } else {
        [data release]; [responseHeaders release];
        data = [[request responseData] mutableCopy]; // retain count of +1
        responseStatusCode = [request responseStatusCode];
        responseHeaders = [[request responseHeaders] copy];
        returnedData = [self parseReturnedData];
        [delegate performSelectorOnMainThread:responseCallback withObject:returnedData waitUntilDone:NO];
    }
    [request release]; request = nil;
    [autoreleasePool release];
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

- (id) parseReturnedData {
	// abstract
    return nil;
}

- (void) cancel {
	[request cancel];
}

@end
