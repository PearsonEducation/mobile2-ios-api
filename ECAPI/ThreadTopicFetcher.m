//
//  ThreadTopicFetcher.m
//  ECAPI
//
//  Created by Tony Hillerson on 4/26/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ThreadTopicFetcher.h"
#import "ECConstants.h"
#import "SBJsonParser.h"
#import "ECJSONUnarchiver.h"
#import "UserDiscussionTopic.h"
#import "ContainerInfo.h"

@implementation ThreadTopicFetcher

- (void) fetchDiscussionTopicsForCourseId:(NSInteger)courseId threadId:(NSNumber *)tid {
	threadId = tid;
	NSString *url = [NSString stringWithFormat:@"%@/me/userTopics.json?courses=%d", M_API_URL, courseId];
	[self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeAndFilterTopics:)];
}

- (id) deserializeAndFilterTopics:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary *)parsedData;
    if ([parsedDictionary objectForKey:@"userTopics"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray *unfilteredTopics = [unarchiver decodeArrayForKey:@"userTopics" ofType:[UserDiscussionTopic class]];
		NSMutableArray *userDiscussionTopics = [NSMutableArray array];
		for (UserDiscussionTopic *topic in unfilteredTopics) {
			ContainerInfo *containerInfo = topic.topic.containerInfo;
			if ([containerInfo.contentItemId isEqualToNumber:threadId]) [userDiscussionTopics addObject:topic];
		}
        return [NSArray arrayWithArray:userDiscussionTopics];
    } else {
        return nil;
    }
}


@end
