//
//  GradeBookItemGradeFetcher.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface GradebookItemGradeFetcher : ECAuthenticatedFetcher {
}

- (void)loadGradebookItemGradeForCourseId:(NSInteger)courseId andGradebookGuid:(NSString*)gradebookGuid;

@end
