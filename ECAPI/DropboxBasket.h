//
//  DropboxBasket.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DropboxBasket : NSObject {
    NSNumber* dropboxBasketId;
    NSString* title;
    NSArray* links;
}

@property (nonatomic, retain) NSNumber* dropboxBasketId;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSArray* links;

@end
