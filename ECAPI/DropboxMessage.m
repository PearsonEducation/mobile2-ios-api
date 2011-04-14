//
//  DropboxMessage.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/17/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "DropboxMessage.h"
#import "ECCoder.h"
#import "DropboxAttachment.h"

@implementation DropboxMessage

@synthesize dropboxAttachmentId;
@synthesize date;
@synthesize comments;
@synthesize submissionStudent;
@synthesize author;
@synthesize attachments;

- (NSString*)nameOfSubmissionStudent {
    if (submissionStudent && submissionStudent.firstName && submissionStudent.lastName) {
        return [NSString stringWithFormat:@"%@ %@", submissionStudent.firstName, submissionStudent.lastName];
    } else {
        return NSLocalizedString(@"Unknown",nil);
    }
}

- (id) initWithCoder:(NSCoder<ECCoder> *)coder {
	if ((self == [super init])) {
        self.dropboxAttachmentId    = [coder decodeIntegerForKey:@"id"];
        self.date                   = [coder decodeDateForKey:@"date"];
        self.comments               = [coder decodeObjectForKey:@"comments"];
        self.submissionStudent      = [coder decodeObjectForKey:@"submissionStudent" ofType:[User class]];
        self.author                 = [coder decodeObjectForKey:@"author" ofType:[User class]];
        self.attachments            = [coder decodeArrayForKey:@"attachments" ofType:[DropboxAttachment class]];
    }
    return self;
}

- (void) dealloc {
    self.date = nil;
    self.comments = nil;
    self.submissionStudent = nil;
    self.author = nil;
    self.attachments = nil;
	[super dealloc];
}

@end