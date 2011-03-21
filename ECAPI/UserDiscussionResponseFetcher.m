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

#pragma mark post methods


- (void)postResponseToResponseId:(NSInteger)responseId andTitle:(NSString*)title andText:(NSString*)text {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:title forKey:@"title"];
    [dict setValue:text forKey:@"description"];
    NSString* url = [NSString stringWithFormat:@"%@/me/responses/%d/responses", M_API_URL, responseId];
    [self postParams:dict toURLFromString:url withDeserializationSelector:@selector(deserializePostResponseToResponse:)];
}

- (void)postResponseToTopicId:(NSInteger)topicId andTitle:(NSString*)title andText:(NSString*)text {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:title forKey:@"title"];
    [dict setValue:text forKey:@"description"];
    NSString* url = [NSString stringWithFormat:@"%@/me/topics/%d/responses", M_API_URL, topicId];
    [self postParams:dict toURLFromString:url withDeserializationSelector:@selector(deserializePostResponseToTopic:)];    
}

#pragma mark fetcher functions

- (void)fetchUserDiscussionResponseByUserId:(NSInteger)userId andResponseId:(NSInteger)responseId {
    if (userId > 0 && responseId > 0) {
        NSString* url = [NSString stringWithFormat:@"%@/me/userresponses/%d-%d", M_API_URL, userId, responseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponseFromArray:)];
    } else {
        NSLog(@"Invalid userId (%d) or responseId (%d) when loading user discussion response",userId,responseId);
    }
}

- (void)fetchUserDiscussionResponseByUserResponseId:(NSString*)userResponseId {
    if (![userResponseId isEqualToString:@""]) {
        NSString* url = [NSString stringWithFormat:@"%@/me/userresponses/%@", M_API_URL, userResponseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponseFromArray:)];        
    } else {
        NSLog(@"Invalid user response (%@) id when loading user discussion response", userResponseId);
    }
}

- (void)fetchDiscussionResponsesForResponse:(UserDiscussionResponse*)userDiscussionResponse {
    if (userDiscussionResponse && userDiscussionResponse.userDiscussionResponseId > 0) {
        NSString* url = [NSString stringWithFormat:@"%@/me/responses/%d/userresponses", M_API_URL, userDiscussionResponse.userDiscussionResponseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponses:)];
    } else {
        NSLog(@"Invalid user discussion response (%@) or id (%d) when loading user discussion responses for response", userDiscussionResponse, userDiscussionResponse.userDiscussionResponseId);
    }
}

- (void)fetchUserDiscussionResponseForTopic:(UserDiscussionTopic*)userDiscussionTopic {
    if (userDiscussionTopic && userDiscussionTopic.userDiscussionTopicId > 0) {
        NSString* url = [NSString stringWithFormat:@"%@/me/topics/%d/userresponses", M_API_URL, userDiscussionTopic.userDiscussionTopicId];
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

- (id)deserializePostResponseToResponse:(id)parsedData {
    NSLog(@"Received parsedData from posting response to response");
    return nil;
}

- (id)deserializePostResponseToTopic:(id)parsedData {
    NSLog(@"Received parsedData from posting response to topic");
    return nil;
}

@end
