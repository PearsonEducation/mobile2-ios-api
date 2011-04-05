//
//  RosterUser.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/4/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RosterUser : NSObject {
    NSInteger rosterUserId;
    NSString* roleType;
    NSString* firstName;
    NSString* lastName;
    NSString* personaId;
    NSString* fullNameString;
}

- (NSString*) fullName;
- (NSString*) friendlyRole;


@property (nonatomic, assign) NSInteger rosterUserId;
@property (nonatomic, retain) NSString* roleType;
@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;
@property (nonatomic, retain) NSString* personaId;
@property (nonatomic, retain) NSString* fullNameString;

@end
