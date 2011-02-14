//
//  Grade.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/11/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Grade : NSObject {
    float average;
	float earned;
	float possible;
	float extraCredit;
	BOOL isWeightingOn;
	BOOL shareWithStudent;
	NSString *letterGrade;
	NSString *letterGradeComments;
}

@property(nonatomic, assign) float average;
@property(nonatomic, assign) float earned;
@property(nonatomic, assign) float possible;
@property(nonatomic, assign) float extraCredit;
@property(nonatomic, assign) BOOL isWeightingOn;
@property(nonatomic, assign) BOOL shareWithStudent;
@property(nonatomic, copy) NSString *letterGrade;
@property(nonatomic, copy) NSString *letterGradeComments;

@end
