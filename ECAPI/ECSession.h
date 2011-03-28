//
//  ECSession.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest, AccessToken, ECTokenFetcher;

@interface ECSession : NSObject {
	id currentAuthenticationDelegate;
	SEL currentAuthenticationCallback;
	AccessToken *currentGrantToken;
	AccessToken *currentAccessToken;
	ECTokenFetcher *tokenFetcher;
	ECTokenFetcher *grantTokenFetcher;
}

@property(nonatomic, retain) AccessToken *currentGrantToken;
@property(nonatomic, retain) AccessToken *currentAccessToken;

+ (ECSession *) sharedSession;

- (BOOL) hasActiveAccessToken;
- (BOOL) hasActiveGrantToken;
- (void) authenticateWithClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password keepUserLoggedIn:(BOOL)keepUserLoggedIn delegate:(id)delegate callback:(SEL)callbackSelector;
// - (void) authenticateWithRememberedCredentialsAndDelegate:(id)delegate callback:(SEL)callbackSelector;
- (void) setGrantToken:(AccessToken *)token;

- (void) forgetCredentials;
- (void) forgetAccessToken;
- (void) forgetGrantToken;

@end
