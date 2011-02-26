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

@property(nonatomic, readonly) AccessToken *currentGrantToken;
@property(nonatomic, readonly) AccessToken *currentAccessToken;

+ (ECSession *) sharedSession;

- (BOOL) hasUnexpiredAccessToken;
- (BOOL) hasUnexpiredGrantToken;
- (void) authenticateWithClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password keepUserLoggedIn:(BOOL)keepUserLoggedIn delegate:(id)delegate callback:(SEL)callbackSelector;
- (void) authenticateWithCurrentGrantTokenAndDelegate:(id)delegate callback:(SEL)callbackSelector;

- (void) forgetCredentials;

@end
