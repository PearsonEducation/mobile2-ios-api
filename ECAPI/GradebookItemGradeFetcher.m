//
//  GradebookItemGradeFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/15/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "GradebookItemGradeFetcher.h"
#import "GradebookItemGrade.h"
#import "ECJSONUnarchiver.h"

@implementation GradebookItemGradeFetcher

- (void)dealloc {
    [super dealloc];
}

- (void)loadGradebookItemGradeForCourseId:(NSInteger)courseId andGradebookGuid:(NSString*)gradebookGuid {
    if (courseId > 0 && gradebookGuid && ![gradebookGuid isEqualToString:@""]) {
        NSString *url = [NSString stringWithFormat:@"%@/me/courses/%d/gradebookItems/%@/grade", M_API_URL, courseId, gradebookGuid];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeGradebookItemGrade:)];    
    } else {
        NSLog(@"ERROR: cannot load grade without course id and gradebook guid.");
        return;        
    }
}

- (id)deserializeGradebookItemGrade:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary*)parsedData;
	if ([parsedDictionary objectForKey:@"grade"]) {
		NSDictionary *targetDictionary = [parsedDictionary objectForKey:@"grade"];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:targetDictionary];
        GradebookItemGrade* gradebookItemGrade = [[[GradebookItemGrade alloc] initWithCoder:unarchiver] autorelease];
        return gradebookItemGrade;
	} else {
        NSLog(@"ERROR: expected dictionary key 'grade' to reference valid grade data");
		return nil;
	}
}

@end