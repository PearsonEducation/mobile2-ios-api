//
//  ECCoder.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/8/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ECCoder

- (id) decodeObjectForKey:(NSString *)key ofType:(Class<NSCoding>)clazz;
- (NSArray*) decodeArrayForKey:(NSString *)key ofType:(Class<NSCoding>)clazz;
- (NSDate*) decodeDateForKey:(NSString *)key;
- (NSDecimalNumber*) decodeNumberForKey:(NSString *)key;

@end