//
//  ActivityStreamFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface ActivityStreamFetcher : ECAuthenticatedFetcher {
    
}

- (void) fetchMyActivityStream;
- (void) fetchActivityStreamForUserId:(NSNumber *)userId;

@end
