//
//  NSDateUtilities.h
//  eCollege
//
//  Created by Brad Umbaugh on 3/7/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const ISO8601Format;

@interface NSDate (NSDateUtilities)

- (NSString*)iso8601DateString;
- (NSString*)friendlyDateFor:(int)daysFromToday;
- (NSString*)niceAndConcise;
- (NSString*)friendlyDateWithTimeFor:(int)daysFromToday;


@end