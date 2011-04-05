//
//  RosterUser.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "RosterUser.h"
#import "ECCoder.h"

@implementation RosterUser

@synthesize rosterUserId;
@synthesize roleType;
@synthesize firstName;
@synthesize lastName;
@synthesize personaId;
@synthesize fullNameString;

- (id) initWithCoder:(NSCoder<ECCoder>*)coder {
    self = [super init];
    if (self) {
        self.rosterUserId = [coder decodeIntegerForKey:@"id"];
        self.roleType = [coder decodeObjectForKey:@"roleType"];
        self.firstName = [coder decodeObjectForKey:@"firstName"];
        self.lastName = [coder decodeObjectForKey:@"lastName"];
        self.personaId = [coder decodeObjectForKey:@"personaId"];
        
        // this is a convenience for sorting by full name
        self.fullNameString = [self fullName];
    }
    return self;
}

- (NSString*)fullName {
    if (firstName) {
        if (lastName) {
            return [NSString stringWithFormat:@"%@ %@",firstName,lastName];            
        } else {
            return firstName;
        }
    } else if (lastName) {
        return lastName;
    } else {
        return nil;
    }
}

- (NSString*)friendlyRole {
    if (roleType) {
        NSString* lcRole = [self.roleType lowercaseString];
        if ([@"stud" isEqualToString:lcRole]) {
            return NSLocalizedString(@"Student", nil);
        } else if ([@"prof" isEqualToString:lcRole]) {
            return NSLocalizedString(@"Instructor", nil);
        }
    }
    return nil;
}

- (void)dealloc {
    self.fullNameString = nil;
    self.roleType = nil;
    self.firstName = nil;
    self.lastName = nil;
    self.personaId = nil;
    [super dealloc];
}

@end
