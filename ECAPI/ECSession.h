//
//  ECSession.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;

@protocol ECSessionAuthenticationDelegate<NSObject>
@required
- (void) sessionDidAuthenticate:(id)session;
@end

@interface ECSession : NSObject {
	id<ECSessionAuthenticationDelegate> authenticationDelegate;
	NSString *clientId;
	NSString *clientString;
	NSString *username;
	NSString *accessToken;
	ASIFormDataRequest *authenticationRequest;
	
@private
	NSString *_password;
}

@property(nonatomic, retain) id<ECSessionAuthenticationDelegate> authenticationDelegate;
@property(nonatomic, readonly) NSString *clientString;
@property(nonatomic, readonly) NSString *username;
@property(nonatomic, readonly) NSString *accessToken;
@property(nonatomic, readonly) BOOL isAuthenticated;

+ (ECSession *) sharedSession;

- (void) authenticateWithClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password;

@end
