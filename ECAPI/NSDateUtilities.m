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

@end
