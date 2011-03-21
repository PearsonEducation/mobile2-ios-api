//
//  UserDiscussionResponseFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserDiscussionResponseFetcher.h"
#import "ECJSONUnarchiver.h"

@implementation UserDiscussionResponseFetcher

#pragma mark fetcher functions

- (void)fetchUserDiscussionResponseByUserId:(NSInteger)userId andResponseId:(NSInteger)responseId {
    if (userId > 0 && responseId > 0) {
        NSString* url = [NSString stringWithFormat:@"/me/userresponses/%d-%d",userId,responseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponseFromArray:)];
    } else {
        NSLog(@"Invalid userId (%d) or responseId (%d) when loading user discussion response",userId,responseId);
    }
}

- (void)fetchUserDiscussionResponseByUserResponseId:(NSString*)userResponseId {
    if (![userResponseId isEqualToString:@""]) {
        NSString* url = [NSString stringWithFormat:@"/me/userresponses/%@",userResponseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponseFromArray:)];        
    } else {
        NSLog(@"Invalid user response (%@) id when loading user discussion response", userResponseId);
    }
}

- (void)fetchDiscussionResponsesForResponse:(UserDiscussionResponse*)userDiscussionResponse {
    if (userDiscussionResponse && userDiscussionResponse.userDiscussionResponseId > 0) {
        NSString* url = [NSString stringWithFormat:@"/me/responses/%d/userresponses", userDiscussionResponse.userDiscussionResponseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponses:)];
    } else {
        NSLog(@"Invalid user discussion response (%@) or id (%d) when loading user discussion responses for response", userDiscussionResponse, userDiscussionResponse.userDiscussionResponseId);
    }
}

- (void)fetchUserDiscussionResponseForTopic:(UserDiscussionTopic*)userDiscussionTopic {
    if (userDiscussionTopic && userDiscussionTopic.userDiscussionTopicId > 0) {
        NSString* url = [NSString stringWithFormat:@"/me/topics/%d/userresponses", userDiscussionTopic.userDiscussionTopicId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponses:)];
    } else {
        NSLog(@"Invalid user discussion topic (%@) or id (%@) when loading user discussion responses for topic", userDiscussionTopic, userDiscussionTopic.userDiscussionTopicId);
    }
}

# pragma mark deserialization methods

- (id)deserializeUserDiscussionResponses:(id)parsedData {
    NSDictionary *parsedDictionary = (NSDictionary*)parsedData;
    if ([parsedDictionary objectForKey:@"userResponses"]) {
        ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:parsedDictionary];
        NSArray* userDiscussionResponses = [unarchiver decodeArrayForKey:@"userResponses" ofType:[UserDiscussionResponse class]];
        return userDiscussionResponses;
    } else {
        NSLog(@"ERROR: expected dictionary key 'userResponses' to reference valid user discussion response data");
        return nil;
    }
}

- (id)deserializeUserDiscussionResponseFromArray:(id)parsedData {
	NSDictionary *parsedDictionary = (NSDictionary*)parsedData;
	if ([parsedDictionary objectForKey:@"userResponses"]) {
        NSArray* userDiscussionResponses = [parsedDictionary objectForKey:@"userResponses"];
        NSDictionary* userResponseDictionary = [userDiscussionResponses objectAtIndex:0];
		ECJSONUnarchiver *unarchiver = [ECJSONUnarchiver unarchiverWithDictionary:userResponseDictionary];
        UserDiscussionResponse* userResponse = [[[UserDiscussionResponse alloc] initWithCoder:unarchiver] autorelease];
        return userResponse;
	} else {
        NSLog(@"ERROR: expected dictionary key 'userResponses' to reference valid user discussion response data");
		return nil;
	}
}

@end