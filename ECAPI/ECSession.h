//
//  ECSession.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@protocol ECSessionAuthenticationDelegate<NSObject>
@required
- (void) sessionDidAuthenticate:(id)session;
@end

@interface ECSession : NSObject {
	id<ECSessionAuthenticationDelegate> authenticationDelegate;
	NSString *clientString;
	NSString *username;
	NSString *accessToken;
	ASIHTTPRequest *authenticationRequest;
	
@private
	NSString *_password;
}

@property(nonatomic, retain) id<ECSessionAuthenticationDelegate> authenticationDelegate;
@property(nonatomic, readonly) NSString *clientString;
@property(nonatomic, readonly) NSString *username;
@property(nonatomic, readonly) NSString *accessToken;

- (id) initWithClientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password;

- (void) authenticate;

@end
