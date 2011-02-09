//
//  ECJSONUnarchiver.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/8/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECCoder.h"

@interface ECJSONUnarchiver : NSCoder <ECCoder> {
    NSDictionary *dictionary;
}

- (id) initWithDictionary:(NSDictionary*)dict;
+ (id) unarchiverWithDictionary:(NSDictionary*)dict;

- (id) decodeObjectForKey:(NSString *)key ofType:(Class)clazz;
- (NSArray *) decodeArrayForKey:(NSString *)key ofType:(Class)clazz;
- (NSDate *) decodeDateForKey:(NSString *)key;
- (NSDecimalNumber *) decodeNumberForKey:(NSString *)key;


@end
