
//
//  Announcement.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Announcement : NSObject {
    NSInteger announcementId;
    NSString* subject;
    NSString* text;
    NSString* submitter;
    NSDate* startdisplayDate;
    NSDate* endDisplayDate;
    NSString* rawText;
}

@property (nonatomic, assign) NSInteger announcementId;
@property (nonatomic, retain) NSString* subject;
@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSString* submitter;
@property (nonatomic, retain) NSDate* startDisplayDate;
@property (nonatomic, retain) NSDate* endDisplayDate;
@property (nonatomic, retain) NSString* rawText;

@end
