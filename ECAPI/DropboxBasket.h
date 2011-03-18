//
//  DropboxBasket.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/18/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DropboxBasket : NSObject {
    NSInteger dropboxBasketId;
    NSString* title;
    NSArray* links;
}

@property (nonatomic, assign) NSInteger dropboxBasketId;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSArray* links;

@end
