//
//  GradebookItemFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"


@interface GradebookItemFetcher : ECAuthenticatedFetcher {
    
}

- (void)fetchMyGradebookItemsForCourseId:(NSInteger)courseId;
- (void)fetchGradebookItemByGuid:(NSString*)guid forCourseId:(NSInteger)courseId;

@end
