//
//  Course.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/3/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject {
	NSNumber *courseId;
	NSString *displayCourseCode;
	NSString *title;
	
	NSArray *callNumbers;
	
	// Expandable collections
	NSArray *instructors;
	NSArray *teachingAssistants;
	NSArray *students;
	
	// TODO: Links? Term seems to be one
}

@property(nonatomic, retain) NSNumber *courseId;
@property(nonatomic, retain) NSString *displayCourseCode;
@property(nonatomic, retain) NSString *title;

@property(nonatomic, retain) NSArray *callNumbers;

// Expandable collections
@property(nonatomic, retain) NSArray *instructors;
@property(nonatomic, retain) NSArray *teachingAssistants;
@property(nonatomic, retain) NSArray *students;

+ (Course *) courseFromDictionary:(NSDictionary *)courseDictionary;

@end
