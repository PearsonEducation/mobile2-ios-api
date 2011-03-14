//
//  DateCalculator.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/9/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DateCalculator.h"


@implementation DateCalculator

@synthesize calendar;

- (id)initWithCalendar:(NSCalendar*)cal {
    if ((self = [super init])) {
        self.calendar = cal;
        scratchComponents = [[NSDateComponents alloc] init];
    }
    return self;
}

- (NSDate*)midnight:(int)num fromDate:(NSDate*)date {
    // add one to the current date to move to the next day
    scratchComponents.day = num;
    NSDate *nextDay = [calendar dateByAddingComponents:scratchComponents toDate:date options:0];
    
    // find midnight on the next day
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* components = [calendar components:unitFlags fromDate:nextDay];
    components.hour = 0;
    components.minute = 0;
    return [calendar dateFromComponents:components];
}

- (BOOL)date:(NSDate*)date1 comesBefore:(NSDate*)date2 inclusive:(BOOL)inclusive {
    BOOL val = ([date1 compare:date2] == NSOrderedAscending);
    return inclusive ? ( val || [date1 isEqualToDate:date2] ) : val;
}

- (BOOL)date:(NSDate*)date1 comesAfter:(NSDate*)date2 inclusive:(BOOL)inclusive {
    BOOL val = ([date1 compare:date2] == NSOrderedDescending);
    return inclusive ? ( val || [date1 isEqualToDate:date2] ) : val;
}

- (int)datesFrom:(NSDate*)date1 to:(NSDate*)date2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSDate* date1Midnight = [self midnight:0 fromDate:date1];
    NSDate* date2Midnight = [self midnight:0 fromDate:date2];
    NSDateComponents* components = [calendar components:unitFlags fromDate:date1Midnight toDate:date2Midnight options:0];
    return components.day;
}

- (NSDate*)addDays:(int)days toDate:(NSDate*)date {
    scratchComponents.day = days;
    return [calendar dateByAddingComponents:scratchComponents toDate:date options:0];
}

- (void) dealloc {
    self.calendar = nil;
    [scratchComponents release];
    [super dealloc];
}

@end
