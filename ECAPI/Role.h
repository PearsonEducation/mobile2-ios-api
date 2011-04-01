
//
//  Role.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject {
    NSInteger roleId;
    NSString* type;
    NSString* name;
}

@property (nonatomic, assign) NSInteger roleId;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* name;

@end
