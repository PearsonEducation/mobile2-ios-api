//
//  User.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
	NSNumber *userId;
	NSString *userName;
	NSString *firstName;
	NSString *lastName;
	NSString *emailAddress;
	NSString *clientString;
}

- (NSString*)fullName;

@property(nonatomic, retain) NSNumber *userId;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *firstName;
@property(nonatomic, copy) NSString *lastName;
@property(nonatomic, copy) NSString *emailAddress;
@property(nonatomic, copy) NSString *clientString;

@end
