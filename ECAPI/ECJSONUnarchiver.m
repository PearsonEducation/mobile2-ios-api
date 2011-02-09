//
//  ECJSONUnarchiver.m
//  ECAPI
//
//  Created by Tony Hillerson on 2/8/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECJSONUnarchiver.h"

static NSString *ISO8601Format = @"yyyy-MM-dd'T'HH:mm:ss";

@implementation ECJSONUnarchiver

- (id) initWithDictionary:(NSDictionary*)dict {
	if ((self = [super init])){
		dictionary = [dict retain];
	}
	return self;
}

+ (id) unarchiverWithDictionary:(NSDictionary*)dict {
	ECJSONUnarchiver *unarch = [[ECJSONUnarchiver alloc] initWithDictionary:dict];
	return [unarch autorelease];
}

- (BOOL) decodeBoolForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return NO;
	}
	return [(NSNumber*)val boolValue];
}

- (NSInteger) decodeIntegerForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return 0;
	}
	return [(NSNumber*)val integerValue];
}

- (double) decodeDoubleForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return 0.00;
	}
	return [(NSNumber*)val doubleValue];
}

- (NSObject*) decodeObjectForKey:(NSString *)key {
	NSObject *val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	return val;
}

- (NSDate*) decodeDateForKey:(NSString *)key {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:ISO8601Format];
    NSDate *date = [dateFormatter dateFromString:(NSString*)val];
	[dateFormatter release];
	return date;
}

- (NSDecimalNumber*) decodeNumberForKey:(NSString *)key {
	return [self decodeObjectForKey:key];
}

- (id) decodeObjectForKey:(NSString *)key ofType:(Class)clazz {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	ECJSONUnarchiver *unarch = [ECJSONUnarchiver unarchiverWithDictionary:(NSDictionary*)val];
	NSObject *obj = [(id<NSCoding>)[clazz alloc] initWithCoder:unarch];
	return [obj autorelease];
}

- (NSArray*) decodeArrayForKey:(NSString *)key ofType:(Class)clazz {
	id val = [dictionary objectForKey:key];
	if (!val || val == [NSNull null]) {
		return nil;
	}
	NSMutableArray* m_arr = [NSMutableArray array];	
	for (NSDictionary *dict in (NSArray*)val) {
		ECJSONUnarchiver *unarch = [ECJSONUnarchiver unarchiverWithDictionary:dict];
		NSObject *obj = [(id<NSCoding>)[clazz alloc] initWithCoder:unarch];
		[m_arr addObject:obj];
		[obj release];
	}
	return m_arr;	
}

- (void) dealloc {
	[dictionary release];
	[super dealloc];
}

@end
