//
//  UpcomingEventItemsFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/21/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface UpcomingEventItemsFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchMyUpcomingEventItems;

@end
