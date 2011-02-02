//
//  ECUtils.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECUtils.h"


@implementation ECUtils

+ (NSString *) stringOrEmptyStringFromStringOrNull:(id)stringOrNull {
	if ([stringOrNull class] == [NSNull class]) {
		return @"";
	} else {
		return (NSString *)stringOrNull;
	}
	
}

@end
