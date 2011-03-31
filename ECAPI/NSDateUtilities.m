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

- (NSString*) iso8601DateString {
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:ISO8601Format];
    NSString* dateString = [dateFormat stringFromDate:self];
    //NSLog(@"Date string: %@", dateString);
    return dateString;
}

- (NSString*)dateString:(NSString*)formatString {
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:self];
    return dateString;
}

- (NSInteger)year {
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    return [[gregorian components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:self] year];
}

- (NSDate*)addDays:(NSInteger)numDays {
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDateComponents* components = [[[NSDateComponents alloc] init] autorelease];
    components.day = numDays;
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSString*)friendlyDateFor:(int)daysFromToday {
    if (daysFromToday == 0) {
        return NSLocalizedString(@"Today", @"The word meaning 'today'");
    } else if(daysFromToday == 1) {
        return NSLocalizedString(@"Tomorrow", @"The word meaning 'tomorrow'");
    } else if(daysFromToday == -1) {
        return NSLocalizedString(@"Yesterday", @"The word meaning 'yesterday'");
    } else {
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        //The following format does: MMMM dd, yyyy
        //[formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setDateFormat:@"MMM d"];
        return [formatter stringFromDate:self];
    }
}

- (NSString*)friendlyDateWithTimeFor:(int)daysFromToday {
    NSString* day = [self friendlyDateFor:daysFromToday];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"h:mm a"];
    NSString* time = [formatter stringFromDate:self];
    return [NSString stringWithFormat:@"%@ %@",day,time];
}

// http://stackoverflow.com/questions/902950/iphone-convert-date-string-to-a-relative-time-stamp
-(NSString *)niceAndConcise {
    NSDate *todayDate = [NSDate date];
    double ti = [self timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if (ti < 60) {
        return @"less than a minute ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        if (diff == 1) {
            return [NSString stringWithFormat:@"%d minute ago", diff];            
        } else {
            return [NSString stringWithFormat:@"%d minutes ago", diff];                        
        }
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        if (diff == 1) {
            return [NSString stringWithFormat:@"%d hour ago", diff];            
        } else {
            return [NSString stringWithFormat:@"%d hours ago", diff];                        
        }
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        if (diff == 1) {
            return [NSString stringWithFormat:@"%d day ago", diff];            
        } else {
            return [NSString stringWithFormat:@"%d days ago", diff];                        
        }
    } else {
        return @"";
    }   
}

//- (NSString*)friendlyString {
//    NSString* dtstr = [self dateString:@"MMM d yyyy"];
//    NSDate* now = [NSDate date];
//    if ([[now dateString:@"MMM d yyyy"] isEqualToString:dtstr]) {
//        return NSLocalizedString(@"Today", nil);
//    } 
//    if ([[[now addDays:-1] dateString:@"MMM d yyyy"] isEqualToString:dtstr]) {
//        return NSLocalizedString(@"Yesterday",nil);
//    }
//    if ([self year] != [now year]) {
//        return dtstr;
//    } else {
//        return [self dateString:@"MMM d"];
//    }
//    return nil;
//}

- (BOOL)isToday {
    return [[[NSDate date] dateString:@"MMM d yyyy"] isEqualToString:[self dateString:@"MMM d yyyy"]];
}

- (NSString*)friendlyString {
    NSString* format = @"MMM d, yyyy";
    NSString* dtstr = [self dateString:format];
    NSDate* now = [NSDate date];
    if ([[now dateString:format] isEqualToString:dtstr]) {
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Today",  nil), [now dateString:@"h:mm a"]];
    } 
    if ([[[now addDays:-1] dateString:format] isEqualToString:dtstr]) {
        return NSLocalizedString(@"Yesterday",  nil);

    }
    if ([self year] != [now year]) {
        return dtstr;
    } else {
        return [self dateString:@"MMM d"];
    }
    return nil;
}


@end
