//
//  ECTokenFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface ECTokenFetcher : ECAuthenticatedFetcher {
    
}

- (void) fetchAccessTokenForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password;
- (void) fetchAccessGrantForClientId:(NSString *)clientId clientString:(NSString *)clientString username:(NSString *)username password:(NSString *)password;
- (void) fetchAccessTokenWithAccessGrant:(NSString *)accessGrantToken;


@end
