//
//  NSDateUtilities.m
//  eCollege
//
//  Created by Brad Umbaugh on 3/7/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "NSDateUtilities.h"

NSString* const ISO8601Format = @"yyyy-MM-dd'T'HH:mm:ss'Z'";

@implementation NSDate (NSDateUtilities)

- (NSDate*) nextDayLocalMidnight {
    // need a calendar in the local time zone to find nextDay midnight
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
 
    // add one to the current date to move to the next day
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    NSDate *nextDay = [gregorian dateByAddingComponents:components toDate:self options:0];
    [components release];
    
    // find midnight on the next day
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    components = [gregorian components:unitFlags fromDate:nextDay];
    components.hour = 0;
    components.minute = 0;
    NSDate *nextDayMidnight = [gregorian dateFromComponents:components];
    
    NSLog(@"nextDay midnight: %@", [nextDayMidnight iso8601DateString]);
    return nextDayMidnight;
    
}

- (NSString*) iso8601DateString {
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:ISO8601Format];
    NSString* dateString = [dateFormat stringFromDate:self];
    //NSLog(@"Date string: %@", dateString);
    return dateString;
}

- (BOOL) comesBefore:(NSDate*)d {
    return ([self compare:d] == NSOrderedAscending);
}

- (BOOL) comesAfter:(NSDate*)d {
    return ([self compare:d] == NSOrderedDescending);
}

- (NSDate*) addDays:(int)days {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    NSDate* newDate = [gregorian dateByAddingComponents:components toDate:self options:0];
    [components release];    
    return newDate;
}

@end
