//
//  UserGradebookItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserGradebookItem.h"
#import "ECCoder.h"
#import "GradeLink.h"

@implementation UserGradebookItem
@synthesize userGradebookItemId, gradebookItem, gradeLinks;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.userGradebookItemId    = [coder decodeIntegerForKey:@"id"];
        self.gradebookItem          = [coder decodeObjectForKey:@"gradebookItem" ofType:[GradebookItem class]];
		self.gradeLinks				= [coder decodeArrayForKey:@"links" ofType:[GradeLink class]];
    }
	return self;
}

- (Grade *) grade {
	if (gradeLinks && [gradeLinks count] > 0) {
		GradeLink *link = (GradeLink *)[gradeLinks objectAtIndex:0];
		return link.grade;
	}
	return nil;
}

- (void)dealloc {
    self.gradebookItem = nil;
	self.gradeLinks = nil;
}

@end
