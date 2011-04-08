//
//  ActivityStreamItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//  

#import "ActivityStreamItem.h"
#import "ECCoder.h"
#import "NSDateUtilities.h"
#import "ActivityStreamObject.h"

@implementation ActivityStreamItem

@synthesize activityStreamItemId;
@synthesize postedTime;
@synthesize actor;
@synthesize verb;
@synthesize object;
@synthesize target;
@synthesize friendlyDate;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.activityStreamItemId             = [coder decodeObjectForKey:@"id"];
        self.postedTime                       = [coder decodeDateForKey:@"postedTime"];
        self.actor                            = [coder decodeObjectForKey:@"actor" ofType:[ActivityStreamActor class]];
        self.verb                             = [coder decodeObjectForKey:@"verb"];
        self.object                           = [coder decodeObjectForKey:@"object" ofType:[ActivityStreamObject class]];
        self.target                           = [coder decodeObjectForKey:@"target" ofType:[ActivityStreamTarget class]];
    }
	return self;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@", [postedTime iso8601DateString]];
}

- (NSString*)getTitle {
    NSString* type = [self getType];
    if ([type isEqualToString:@"grade"] || [type isEqualToString:@"dropbox-submission"]) {
        if (self.target && self.target.title) {
            return self.target.title;
        }
    } else {
        if (self.object && self.object.title) {
            return self.object.title;
        }
    }
    return nil;
}

- (NSString*)getDescription {
    NSString* type = [self getType];
    if ([type isEqualToString:@"grade"]) {
        NSString* letterGrade = nil;
        NSDecimalNumber* pointsAchieved = nil;
        NSDecimalNumber* pointsPossible = nil;
        
        // first, attempt to get points...
        if (self.object && self.object.pointsAchieved) {
            pointsAchieved = self.object.pointsAchieved;
        }
        if (self.target && self.target.pointsPossible) {
            pointsPossible = self.target.pointsPossible;
        }
        if (pointsAchieved && pointsPossible) {
            return [NSString stringWithFormat:@"%@/%@", pointsAchieved, pointsPossible];
        }
        
        // second, attempt to get letter grade
        if (self.object && self.object.letterGrade) {
            letterGrade = self.object.letterGrade;
        }
        
        // may still be nil
        return letterGrade;
    } else {
        if (self.object && self.object.summary) {
            return self.object.summary;
        }
    }
    return nil;
}

- (NSString*)getType {
    if (self.object && ![self.object.objectType isEqualToString:@""]) {
        return self.object.objectType;
    } else {
        return nil;
    }
}

- (void) dealloc {
    self.friendlyDate = nil;
    self.activityStreamItemId = nil;
    self.postedTime = nil;
    self.actor = nil;
    self.verb = nil;
    self.object = nil;
    self.target = nil;
    [super dealloc];
}

@end
