//
//  GradeLink.h
//  ECAPI
//
//  Created by Tony Hillerson on 4/5/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Link.h"
#import "Grade.h"

@interface GradeLink : Link {
    Grade *grade;
}

@property (nonatomic, retain) Grade *grade;

@end
