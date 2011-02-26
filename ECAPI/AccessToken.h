//
//  AccessGrant.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/25/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccessToken : NSObject {
    NSString *accessToken;
    NSString *refreshToken;
	NSDate *expiresAt;
}

@property(nonatomic, copy) NSString *accessToken;
@property(nonatomic, copy) NSString *refreshToken;
@property(nonatomic, retain) NSDate *expiresAt;

- (id) initWithDictionary:(NSMutableDictionary *)dictionary;
- (void) saveInDictionary:(NSMutableDictionary *)dictionary;
- (BOOL) isExpired;

@end
