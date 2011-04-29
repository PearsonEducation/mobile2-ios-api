//
//  UserDiscussionTopicFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserDiscussionTopicFetcher.h"
#import "UserDiscussionTopic.h"
#import "ECJSONUnarchiver.h"

@implementation UserDiscussionTopicFetcher

# pragma mark fetch methods

- (void)fetchDiscussionTopicById:(NSNumber *)userId andTopicId:(NSNumber *)topicId {
    NSString* url = [NSString stringWithFormat:@"%@/me/usertopics/%@-%@", M_API_URL, userId, topicId ];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionTopicFromArray:)];
}

- (void)fetchDiscussionTopicById:(NSString*)userTopicId {
    NSString* url = [NSString stringWithFormat:@"%@/me/usertopics/%@", M_API_URL, userTopicId];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionTopicFromArray:)];
}

- (void)fetchDiscussionTopicsForCourseIds:(NSArray*)courseIds {
    NSString* formattedCourseIds = [courseIds objectAtIndex:0];
    for (int i=1; i < [courseIds count]; i += 1) {
        formattedCourseIds = [NSString stringWithFormat:@"%@;%@",formattedCourseIds,[courseIds objectAtIndex:i]];
    }
    NSString* url = [NSString stringWithFormat:@"%@/me/userTopics?courses=%@",M_API_URL, formattedCourseIds];
    [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionTopics:)];
}

# pragma mark deserialization methods

- (id)deserializeUserDiscussionTopicFromArray:(id)parsedData {    
	NSDictionary *parsedDictionary = (NSDictionary*)parsedData;
	if ([parsedDictionary objectForKey:@"userTopics"]) {
        NSArray* userDiscussionTopics = [parsedDictionary objectForKey:@"userTopics"];
        NSDictionary* userTopicDictionary = [userDiscussionTopics objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:userTopicDictionary];
        UserDiscussionTopic* userTopic = [[[UserDiscussionTopic alloc] initWithCoder:unarchiver] autorelease];
        return userTopic;
	} else {
        NSLog(@"ERROR: expected dictionary key 'userTopics' to reference valid user discussion topic data");
		return nil;
	}
}

- (id)deserializeUserDiscussionTopics:(id)parsedData {    
    NSDictionary *parsedDictionary = (NSDictionary*)parsedData;
    if ([parsedDictionary objectForKey:@"userTopics"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray* userDiscussionTopics = [unarchiver decodeArrayForKey:@"userTopics" ofType:[UserDiscussionTopic class]];
        return userDiscussionTopics;
    } else {
        NSLog(@"ERROR: expected dictionary key 'userTopics' to reference valid user discussion topic data");
        return nil;
    }
}

                                                                          
                                                                          

@end
