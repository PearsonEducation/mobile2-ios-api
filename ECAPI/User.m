//
//  User.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize userId, userName, firstName, lastName, emailAddress, clientString;

+ (User *) userFromDictionary:(NSDictionary *)dictionary {
	User *user = [[[User alloc] init] autorelease];
	user.userId = [dictionary objectForKey:@"id"];
	user.userName = [dictionary objectForKey:@"userName"];
	user.firstName = [dictionary objectForKey:@"firstName"];
	user.lastName = [dictionary objectForKey:@"lastName"];
	user.emailAddress = [dictionary objectForKey:@"emailAddress"];
	user.clientString = [dictionary objectForKey:@"clientString"];
	return user;
}

@end
