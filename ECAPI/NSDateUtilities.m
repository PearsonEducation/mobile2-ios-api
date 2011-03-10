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

@end
