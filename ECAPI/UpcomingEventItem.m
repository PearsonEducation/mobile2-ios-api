//
//  UpcomingEventItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/21/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UpcomingEventItem.h"
#import "ECCoder.h"
#import "WhenWrapper.h"
#import "Link.h"

@implementation UpcomingEventItem

@synthesize when;
@synthesize upcomingEventItemId;
@synthesize type;
@synthesize title;
@synthesize dateString;
@synthesize category;
@synthesize links;
@synthesize threadId;
@synthesize multimediaId;
@synthesize categoryType;
@synthesize eventType;

- (id) initWithCoder:(NSCoder<ECCoder>*)coder {
    self = [super init];

    _courseId = [[NSNumber numberWithInt:-1] retain];
    _cat = -1;
    _uet = -1;
    
    if (self) {
        self.when = [coder decodeObjectForKey:@"when" ofType:[WhenWrapper class]];
        self.upcomingEventItemId = [coder decodeNumberForKey:@"id"];
        self.type = [coder decodeObjectForKey:@"type"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.category = [coder decodeObjectForKey:@"category"];
        self.links = [coder decodeArrayForKey:@"links" ofType:[Link class]];
    }
    return self;
}

- (NSNumber *)courseId {
    if ([_courseId isEqualToNumber:[NSNumber numberWithInt:-1]]) {
        for (Link* link in links) {
            if (link.href) {
                NSRange coursesRange = [link.href rangeOfString:@"courses/"];
                if (coursesRange.location != NSNotFound) {
                    NSString* stringAfterCourses = [link.href substringFromIndex:(coursesRange.location + coursesRange.length)];
                    NSRange slashRange = [stringAfterCourses rangeOfString:@"/"];
                    if (slashRange.location != NSNotFound) {
                        _courseId = [[NSNumber numberWithInt:[[stringAfterCourses substringToIndex:slashRange.location] integerValue]] retain];
                    }
                }
            }
        }
    }
    return _courseId;
}

- (NSNumber *)threadId {
    return upcomingEventItemId;
}

- (NSNumber *)multimediaId {
    return upcomingEventItemId;
}

- (CategoryType)categoryType {
    if (_cat == -1) {
        NSString* ucCat = [self.category uppercaseString];
        if ([@"START" isEqualToString:ucCat]) {
            _cat = Start;
        } else if ([@"END" isEqualToString:ucCat]) {
            _cat = End;
        } else {
            _cat = Due;
        }
    }
    return _cat;
}

- (UpcomingEventType)eventType {
    if (_uet == -1) {
        NSString* ucType = [type uppercaseString];
        if ([@"HTML" isEqualToString:ucType] || [@"MANAGED_OD" isEqualToString:ucType] || [@"MANAGED_HTML" isEqualToString:ucType]) {
            _uet = Html;
        } else if ([@"THREAD" isEqualToString:ucType] || [@"MANAGED_THREADS" isEqualToString:ucType]) {
            _uet = Thread;
        } else if ([@"IQT" isEqualToString:ucType]) {
            _uet = QuizExamTest;
        } else {
            _uet = Ignored;
        }
    }
    return _uet;
}

- (void)dealloc {
	[_courseId release]; _courseId = nil;
	self.upcomingEventItemId = nil;
    self.dateString = nil;
    self.when = nil;
    self.type = nil;
    self.title = nil;
    self.category = nil;
    self.links = nil;
    [super dealloc];
}


@end
