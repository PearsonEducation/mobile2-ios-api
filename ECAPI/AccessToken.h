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

@property(nonatomic, assign) NSString *accessToken;
@property(nonatomic, assign) NSString *refreshToken;
@property(nonatomic, assign) NSDate *expiresAt;

@end
