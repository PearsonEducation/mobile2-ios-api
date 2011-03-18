//
//  DropboxMessageFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DropboxBasketFetcher.h"
#import "ECJSONUnarchiver.h"
#import "DropboxBasket.h"

@implementation DropboxBasketFetcher

- (void)fetchDropboxBasketForCourseId:(NSInteger)courseId andBasketId:(NSString*)basketId {
    NSString* url = [NSString stringWithFormat:@"%@/courses/%d/dropboxBaskets/%@", M_API_URL, courseId, basketId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeMe:)];
}

- (id) deserializeMe:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
	if ([parsedDictionary objectForKey:@"dropboxBaskets"]) {
        NSArray* dropboxBaskets = [parsedDictionary objectForKey:@"dropboxBaskets"];
        NSDictionary* dropboxBasketDictionary = [dropboxBaskets objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:dropboxBasketDictionary];
        DropboxBasket* dropboxBasket = [[[DropboxBasket alloc] initWithCoder:unarchiver] autorelease];
        return dropboxBasket;
	} else {
		return nil;
	}
    return nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
