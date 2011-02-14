//
//  CourseFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/10/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface CourseFetcher : ECAuthenticatedFetcher {
    
}

- (void) fetchCourseById:(NSInteger)courseId;
- (void) fetchMyCurrentCourses;
- (void) fetchInstructorsForCourseWithId:(NSInteger)courseId;
- (void) fetchTeachingAssistantsForCourseWithId:(NSInteger)courseId;
- (void) fetchStudentsForCourseWithId:(NSInteger)courseId;
- (void) fetchMyGradeToDateForCourseWithId:(NSInteger)courseId;

@end
