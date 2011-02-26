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
#import "ECTokenFetcher.h"
#import "AccessToken.h"

@interface ECSession (Private)
- (void) loadCurrentGrantToken;
- (void) saveCurrentGrantToken;
@end

@implementation ECSession
static ECSession *sharedSession = nil;
@synthesize currentAccessToken, currentGrantToken;

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
	[currentGrantToken release]; currentGrantToken = nil;
	[currentAccessToken release]; currentAccessToken = nil;
	[tokenFetcher release]; tokenFetcher = nil;
	[grantTokenFetcher release]; grantTokenFetcher = nil;
	[super dealloc];
}

- (BOOL) hasUnexpiredAccessToken {
	return (currentAccessToken != nil && ![currentAccessToken isExpired]);
}

- (void) loadCurrentGrantToken {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *grantKeyDictionary = [defaults objectForKey:@"currentGrantToken"];
	if (grantKeyDictionary) {
		AccessToken *grantToken = [[AccessToken alloc] initWithDictionary:grantKeyDictionary];
		currentGrantToken = grantToken;
	}	
}

- (void) saveCurrentGrantToken {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary *grantKeyDictionary = [NSMutableDictionary dictionaryWithCapacity:3];
	[currentGrantToken saveInDictionary:grantKeyDictionary];
	[defaults setObject:grantKeyDictionary forKey:@"currentGrantToken"];
	[defaults synchronize];
}

- (BOOL) hasUnexpiredGrantToken {
	if (currentGrantToken == nil) {
		[self loadCurrentGrantToken];
	}
	if (currentGrantToken == nil) {
		return NO;
	} else {
		BOOL expired = [currentGrantToken isExpired];
		return !expired;
	}
}

- (void) authenticateWithClientId:(NSString *)cid clientString:(NSString *)cs username:(NSString *)un password:(NSString *)pw keepUserLoggedIn:(BOOL)keepUserLoggedIn delegate:(id)delegate callback:(SEL)callbackSelector {
	//TODO: return an error if invalid credentials
	[self forgetCredentials];
	//TODO: Determine if thread safety is a requirement, because this is not thread safe
	currentAuthenticationDelegate = delegate;
	currentAuthenticationCallback = callbackSelector;
	if (keepUserLoggedIn) {
		grantTokenFetcher = [[ECTokenFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchGrantTokenComplete:)];
		[grantTokenFetcher fetchAccessGrantForClientId:cid clientString:cs username:un password:pw];
	} else {
		tokenFetcher = [[ECTokenFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchTokenComplete:)];
		[tokenFetcher fetchAccessTokenForClientId:cid clientString:cs username:un password:pw];
	}
}

- (void) authenticateWithRememberedCredentialsAndDelegate:(id)delegate callback:(SEL)callbackSelector {
	[currentAccessToken release]; currentAccessToken = nil;
	if (nil == currentGrantToken) {
		[self loadCurrentGrantToken];
	}
	//TODO: return an error if there is no grant token?
	currentAuthenticationDelegate = delegate;
	currentAuthenticationCallback = callbackSelector;
	tokenFetcher = [[ECTokenFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchTokenComplete:)];
	[tokenFetcher fetchAccessTokenWithAccessGrant:currentGrantToken.accessToken];
}

- (void) fetchGrantTokenComplete:(AccessToken *)token {
	//TODO, what to do if there's an error?
	if (![token isKindOfClass:[NSError class]]) {
		[grantTokenFetcher release]; grantTokenFetcher = nil;
		currentGrantToken = [token retain];
		[self saveCurrentGrantToken];
		tokenFetcher = [[ECTokenFetcher alloc] initWithDelegate:self responseSelector:@selector(fetchTokenComplete:)];
		[tokenFetcher fetchAccessTokenWithAccessGrant:token.accessToken];
	}
}

- (void) fetchTokenComplete:(AccessToken *)token {
	if (![token isKindOfClass:[NSError class]]) {
		[tokenFetcher release]; tokenFetcher = nil;
		currentAccessToken = [token retain];
		//TODO: Determine if thread safety is a requirement, because this is not thread safe
		NSObject *del = (NSObject *)currentAuthenticationDelegate;
		[del performSelector:currentAuthenticationCallback];
		currentAuthenticationCallback = nil;
		currentAuthenticationDelegate = nil;
	}
}

- (void) forgetCredentials {
	[currentGrantToken release]; currentGrantToken = nil;
	[currentAccessToken release]; currentAccessToken = nil;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setValue:nil forKey:@"currentGrantToken"];
	[defaults synchronize];
}

@end
