//
//  GradebookItemFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "GradebookItemFetcher.h"
#import "GradebookItem.h"
#import "ECJSONUnarchiver.h"

@interface GradebookItemFetcher ()

- (id)deserializeGradebookItems:(id)parsedData;
- (id)deserializeGradebookItemFromArray:(id)parsedData;

@end

@implementation GradebookItemFetcher

- (void)fetchMyGradebookItemsForCourseId:(NSInteger)courseId {
    NSString* url = [NSString stringWithFormat:@"%@/me/courses/%d/userGradebookItems?expand=grade", M_API_URL, courseId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeGradebookItems:)];    
}

- (void)fetchGradebookItemByGuid:(NSString*)guid forCourseId:(NSInteger)courseId {
    NSString* url = [NSString stringWithFormat:@"%@/courses/%d/gradebookItems/%@", M_API_URL, courseId, guid];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeGradebookItemFromArray:)];
}

- (id)deserializeGradebookItems:(id)parsedData {
    NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"userGradebookItems"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray* gradebookItems = [unarchiver decodeArrayForKey:@"userGradebookItems" ofType:[GradebookItem class]];
        return gradebookItems;
	} else {
		return nil;
	}
}

- (id)deserializeGradebookItemFromArray:(id)parsedData {
    id result = [self deserializeGradebookItems:parsedData];
    if ([result isKindOfClass:[NSArray class]] && [(NSArray*)result count] > 0) {
        return [(NSArray*)result objectAtIndex:0];
    } else {
        return nil;
    }   
}

@end
