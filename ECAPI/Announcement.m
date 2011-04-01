//
//  Announcement.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "Announcement.h"
#import "ECCoder.h"

@implementation Announcement

@synthesize announcementId;
@synthesize subject;
@synthesize text;
@synthesize submitter;
@synthesize startDisplayDate;
@synthesize endDisplayDate;
@synthesize rawText;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.announcementId         = [coder decodeIntegerForKey:@"id"];
        self.subject                = [coder decodeObjectForKey:@"subject"];
        self.text                   = [coder decodeObjectForKey:@"text"];
        self.submitter              = [coder decodeObjectForKey:@"submitter"];
        self.startDisplayDate       = [coder decodeDateForKey:@"startDisplayDate"];
        self.endDisplayDate         = [coder decodeDateForKey:@"endDisplayDate"];
        self.rawText                = [coder decodeObjectForKey:@"rawText"];
    }
	return self;
}

- (void)dealloc {
    self.subject = nil;
    self.text = nil;
    self.submitter = nil;
    self.startDisplayDate = nil;
    self.endDisplayDate = nil;
    self.rawText = nil;
}

@end
