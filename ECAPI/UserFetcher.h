//
//  UserFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface UserFetcher : ECAuthenticatedFetcher {

}

- (void) fetchMe;

@end
