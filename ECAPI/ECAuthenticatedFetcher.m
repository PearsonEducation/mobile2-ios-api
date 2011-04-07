
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
#import "SBJsonParser.h"
#import "AccessToken.h"
#import "ECTokenFetcher.h"
#import "ECConstants.h"
#import "SBJsonWriter.h"

@interface ECAuthenticatedFetcher (PrivateMethods)
+ (void) setCommonHeadersForAuthenticatedRequest:(ASIHTTPRequest *)request;
- (void) loadDataInBackground;
- (void) finishWithObject:(id)obj;
@end

@implementation ECAuthenticatedFetcher

@synthesize responseHeaders, responseStatusCode, ignoreAuthentication;

static SEL generalSelector;
static id generalDelegate;

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
	AccessToken *token = session.currentAccessToken;
	NSString *accessTokenHeaderValue = [NSString stringWithFormat:@"Access_Token access_token=%@", token.accessToken];
	[request addRequestHeader:@"X-Authorization" value:accessTokenHeaderValue];
}

+ (void)setGeneralDelegate:(id)delegateValue andSelector:(SEL)selectorValue {
    if (generalDelegate != delegateValue) {
        [generalDelegate release];
        generalDelegate = [delegateValue retain];
    }
    generalSelector = selectorValue;
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
	[request release]; request = nil;
	[data release]; data = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Git R Dun

- (void) finishWithObject:(id)obj {
    // if there's a general delegate, call out to that first
    if (generalDelegate) {
        [generalDelegate performSelector:generalSelector withObject:obj];
    }    
    // even if the error handler was called, we still need to call back to the main thread, too.
    [delegate performSelectorOnMainThread:responseCallback withObject:obj waitUntilDone:NO];                            
}

- (void) loadDataFromURLString:(NSString *)urlString withDeserializationSelector:(SEL)ds {
	deserializeSelector = ds;
    NSURL *earl = [NSURL URLWithString:urlString];
	request = [ECAuthenticatedFetcher newAuthenticatedGETRequestWithURL:earl];
	NSLog(@"loading data from URL: %@", earl);
    [self performSelectorInBackground:@selector(loadDataInBackground) withObject:nil];
}

- (void) postBody:(NSDictionary*)body toURL:(NSString*)urlString withDeserializationSelector:(SEL)ds {
    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    NSString* jsonString = [writer stringWithObject:body];
    [writer release];
    
    deserializeSelector = ds;
    NSURL *earl = [NSURL URLWithString:urlString];
    request = [ECAuthenticatedFetcher newAuthenticatedGETRequestWithURL:earl];
    [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    
    NSLog(@"Posting string: %@ to url: %@", jsonString, earl);
    
    [self performSelectorInBackground:@selector(loadDataInBackground) withObject:nil];
}

- (void) postParams:(NSDictionary *)params toURLFromString:(NSString *)urlString withDeserializationSelector:(SEL)ds {
	deserializeSelector = ds;
	NSURL *earl = [NSURL URLWithString:urlString];
    
	ASIFormDataRequest *formRequest = [ECAuthenticatedFetcher newAuthenticatedPOSTRequestWithURL:earl];
    
	for (id key in params) {
		[formRequest setPostValue:[params objectForKey:key] forKey:key];
	}
	
	request = formRequest;
	NSLog(@"posting params to URL: %@: %@", earl, params);
    [self performSelectorInBackground:@selector(loadDataInBackground) withObject:nil];
}

- (void) loadDataInBackground {
    NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];

	// First, if we don't have an access token, but have an unexpired grant token
	// get a new access token transparently
	ECSession *session = [ECSession sharedSession];
	if (![session hasActiveAccessToken] && !ignoreAuthentication) {
        if ([session hasActiveGrantToken]) {
			NSLog(@"Have a grant token; fetching an access token");
			ECTokenFetcher *tokenFetcher = [[ECTokenFetcher alloc] init];
			AccessToken *accessToken = [tokenFetcher syncronousFetchAccessTokenWithAccessGrant:session.currentGrantToken.accessToken];
			session.currentAccessToken = accessToken;
			[tokenFetcher release];
			[ECAuthenticatedFetcher setCommonHeadersForAuthenticatedRequest:request];
		} else {
            NSDictionary* dict = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
            [dict setValue:ACCESS_DENIED forKey:ERROR];
            NSError* error = [[NSError alloc] initWithDomain:EC_API_ERROR_DOMAIN code:AUTHENTICATION_ERROR userInfo:dict];
            [self finishWithObject:error];
            [error release];
            return;
		}
	}
	
    // run the synchronous request
	[request startSynchronous];
    
    // check for errors
    NSError *error = [request error];
    id parsedData = nil;
    id objectToReturn;
    if (error) {
        objectToReturn = error;
    } else {
        [data release]; [responseHeaders release];
        data = [[request responseData] mutableCopy]; // retain count of +1
        responseStatusCode = [request responseStatusCode];
        responseHeaders = [[request responseHeaders] copy];
        // 204 means success, but no reason for the server to return anything
        if (responseStatusCode == 204) {
            parsedData = nil;
        } else {
            parsedData = [self parseReturnedData];            
        }
		objectToReturn = parsedData;
		if (!([parsedData isKindOfClass:[NSError class]])) {
			objectToReturn = [self performSelector:deserializeSelector withObject:parsedData];
		}
    }    
    
    // return the object to all delegates
    [self finishWithObject:objectToReturn];
    
    // cleanup
    [request release]; request = nil;
    [autoreleasePool release];
}

- (id) parseReturnedData {
	NSError *deserializationError = nil;
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
    SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *parsedDictionary = (NSDictionary *)[parser objectWithString:jsonString error:&deserializationError];
	
	id objectToReturn = parsedDictionary;
	if (deserializationError) {
		objectToReturn = deserializationError;
	} else if ([parsedDictionary objectForKey:@"error"]) {
		id targetObject = [parsedDictionary objectForKey:@"error"];
		NSString *errorMessage = nil;
		if ([targetObject isKindOfClass:[NSDictionary class]]) {
			NSDictionary *targetDictionary = (NSDictionary *)targetObject;
			errorMessage = [targetDictionary objectForKey:@"message"];
		} else {
			errorMessage = (NSString *)targetObject;
		}
		NSDictionary *info = [NSDictionary dictionaryWithObject:errorMessage forKey:@"message"];
		objectToReturn = [NSError errorWithDomain:EC_API_ERROR_DOMAIN code:responseStatusCode userInfo:info];
	}
    
	[parser release];
	[jsonString release];
	return objectToReturn;
}

- (void) cancel {
	[request cancel];
}

@end
