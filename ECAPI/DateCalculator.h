//
//  DateCalculator.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/9/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateCalculator : NSObject {
    NSCalendar* calendar;
    NSDateComponents* scratchComponents;
}

- (id)initWithCalendar:(NSCalendar*)cal;
- (NSDate*)midnight:(int)num fromDate:(NSDate*)date;
- (BOOL)date:(NSDate*)date1 comesBefore:(NSDate*)date2 inclusive:(BOOL)inclusive;
- (BOOL)date:(NSDate*)date1 comesAfter:(NSDate*)date2 inclusive:(BOOL)inclusive;
- (int)datesFrom:(NSDate*)date1 to:(NSDate*)date2;
- (NSDate*)addDays:(int)days toDate:(NSDate*)date;

@property (nonatomic, retain) NSCalendar* calendar;

@end
