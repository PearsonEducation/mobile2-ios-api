//
//  User.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "User.h"
#import "ECUtils.h"

@implementation User
@synthesize userId, userName, firstName, lastName, emailAddress, clientString;

+ (User *) userFromDictionary:(NSDictionary *)dictionary {
	User *user = [[[User alloc] init] autorelease];
	user.userId = [dictionary objectForKey:@"id"];
	user.userName = [ECUtils stringOrEmptyStringFromStringOrNull:[dictionary objectForKey:@"userName"]];
	user.firstName = [ECUtils stringOrEmptyStringFromStringOrNull:[dictionary objectForKey:@"firstName"]];
	user.lastName = [ECUtils stringOrEmptyStringFromStringOrNull:[dictionary objectForKey:@"lastName"]];
	user.emailAddress = [ECUtils stringOrEmptyStringFromStringOrNull:[dictionary objectForKey:@"emailAddress"]];
	user.clientString = [ECUtils stringOrEmptyStringFromStringOrNull:[dictionary objectForKey:@"clientString"]];
	return user;
}

@end
