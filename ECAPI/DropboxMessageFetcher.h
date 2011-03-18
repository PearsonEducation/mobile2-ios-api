//
//  DropboxMessageFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"


@interface DropboxMessageFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchDropboxMessageForCourseId:(NSInteger)courseId andBasketId:(NSString*)basketId andMessageId:(NSString*)messageId;

@end
