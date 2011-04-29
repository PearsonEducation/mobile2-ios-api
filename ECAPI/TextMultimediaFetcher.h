//
//  TextMultimediaFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 4/27/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECAuthenticatedFetcher.h"

@interface TextMultimediaFetcher : ECAuthenticatedFetcher {
    
}

- (void) fetchHTMLContentForCourseId:(NSNumber *)courseId contentId:(NSNumber *)contentId;

@end
