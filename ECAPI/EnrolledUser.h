
//
//  EnrolledUser.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Role.h"

@interface EnrolledUser : NSObject {
    NSInteger enrolledUserId;
    NSDate* enrollmentDate;
    User* user;
    Role* role;
}

@property (nonatomic, assign) NSInteger enrolledUserId;
@property (nonatomic, retain) NSDate* enrollmentDate;
@property (nonatomic, retain) User* user;
@property (nonatomic, retain) Role* role;

@end
