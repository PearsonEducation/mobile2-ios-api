//
//  User.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
	NSString *userId;
	NSString *userName;
	NSString *firstName;
	NSString *lastName;
	NSString *emailAddress;
	NSString *clientString;
}

@property(nonatomic, retain) NSString *userId;
@property(nonatomic, retain) NSString *userName;
@property(nonatomic, retain) NSString *firstName;
@property(nonatomic, retain) NSString *lastName;
@property(nonatomic, retain) NSString *emailAddress;
@property(nonatomic, retain) NSString *clientString;

+ (User *) userFromDictionary:(NSDictionary *)dictionary;

@end
