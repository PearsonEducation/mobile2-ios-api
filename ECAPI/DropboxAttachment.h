//
//  DropboxAttachment.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DropboxAttachment : NSObject {
    NSInteger dropboxMessageId;
    NSString* name;
    NSString* contentUrl;
}

@property (nonatomic, assign) NSInteger dropboxMessageId;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* contentUrl;

@end