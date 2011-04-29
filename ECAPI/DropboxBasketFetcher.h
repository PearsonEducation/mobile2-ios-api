//
//  DropboxBasketFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"


@interface DropboxBasketFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchDropboxBasketForCourseId:(NSNumber *)courseId andBasketId:(NSString*)basketId;

@end
