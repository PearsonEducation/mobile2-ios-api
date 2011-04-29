
//
//  Role.h
//  ECAPI
//
//  Created by Brad Umbaugh on 4/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject {
    NSNumber* roleId;
    NSString* type;
    NSString* name;
}

@property (nonatomic, retain) NSNumber* roleId;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSString* name;

@end
