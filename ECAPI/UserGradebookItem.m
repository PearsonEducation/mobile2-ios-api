//
//  UserGradebookItem.m
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserGradebookItem.h"
#import "ECCoder.h"

@implementation UserGradebookItem

@synthesize userGradebookItemId;
@synthesize gradebookItem;

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.userGradebookItemId    = [coder decodeIntegerForKey:@"id"];
        self.gradebookItem          = [coder decodeObjectForKey:@"gradebookItem" ofType:[GradebookItem class]];
    }
	return self;
}

- (void)dealloc {
    self.gradebookItem = nil;
}

@end
