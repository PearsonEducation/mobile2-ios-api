//
//  DropboxMessage.h
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DropboxMessage : NSObject {
    NSInteger dropboxAttachmentId;
    NSDate* date;
    NSString* comments;
    User* submissionStudent;
    User* author;
    NSArray* attachments;
}

- (NSString*)nameOfSubmissionStudent;

@property (nonatomic, assign) NSInteger dropboxAttachmentId;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSString* comments;
@property (nonatomic, retain) User* submissionStudent;
@property (nonatomic, retain) User* author;
@property (nonatomic, retain) NSArray* attachments;

@end
