//
//  UserDiscussionResponseFetcher.m
//  ECAPI
//
//  Created by Brad Umbaugh on 3/20/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "UserDiscussionResponseFetcher.h"
#import "ECJSONUnarchiver.h"
#import "UserDiscussionResponse.h"
#import "UserDiscussionTopic.h"

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

- (void)fetchDiscussionResponsesForResponseId:(NSString*)userDiscussionResponseId {
    if (userDiscussionResponseId && ![userDiscussionResponseId isEqualToString:@""]) {
        NSString* url = [NSString stringWithFormat:@"%@/me/responses/%@/userresponses", M_API_URL,userDiscussionResponseId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponses:)];
    } else {
        NSLog(@"Invalid user discussion response (%@) when loading user discussion responses for response", userDiscussionResponseId);
    }
}

- (void)fetchUserDiscussionResponsesForTopicId:(NSString*)userDiscussionTopicId {
    if (userDiscussionTopicId && ![userDiscussionTopicId isEqualToString:@""]) {
        NSString* url = [NSString stringWithFormat:@"%@/me/topics/%@/userresponses", M_API_URL, userDiscussionTopicId];
        [self loadDataFromURLString:url withDeserializationSelector:@selector(deserializeUserDiscussionResponses:)];
    } else {
        NSLog(@"Invalid user discussion topic (%@) when loading user discussion responses for topic", userDiscussionTopicId);
    }
}

- (void)postResponseToTopicWithId:(NSString*)topicId andTitle:(NSString*)title andText:(NSString*)text {
    NSString* url = [NSString stringWithFormat:@"%@/me/topics/%@/responses", M_API_URL, topicId];
    NSMutableDictionary* inner = [[[NSMutableDictionary alloc] initWithCapacity:2] autorelease];
    [inner setValue:title forKey:@"title"];
    [inner setValue:text forKey:@"description"];
    NSMutableDictionary* outer = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
    [outer setValue:inner forKey:@"response"];
    [self postBody:outer toURL:url withDeserializationSelector:@selector(deserializePostResponse:)];
}

- (void)postResponseToResponseWithId:(NSString*)topicId andTitle:(NSString*)title andText:(NSString*)text {
    
    NSString* url = [NSString stringWithFormat:@"%@/me/responses/%@/responses", M_API_URL, topicId];
    NSMutableDictionary* inner = [[[NSMutableDictionary alloc] initWithCapacity:2] autorelease];
    [inner setValue:title forKey:@"title"];
    [inner setValue:text forKey:@"description"];
    NSMutableDictionary* outer = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
    [outer setValue:inner forKey:@"response"];
    [self postBody:outer toURL:url withDeserializationSelector:@selector(deserializePostResponse:)];
}

- (void)markResponseId:(NSString*)responseId asRead:(BOOL)readStatus {
    NSString* url = [NSString stringWithFormat:@"%@/me/responses/%@/readStatus", M_API_URL, responseId];
    NSMutableDictionary* inner = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
    [inner setValue:[[[NSNumber alloc] initWithBool:readStatus] autorelease] forKey:@"markedAsRead"];
    NSMutableDictionary* outer = [[[NSMutableDictionary alloc] initWithCapacity:1] autorelease];
    [outer setValue:inner forKey:@"readStatus"];
    [self postBody:outer toURL:url withDeserializationSelector:@selector(deserializeMarkResponseAsRead:)];
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

- (id)deserializePostResponse:(id)parsedData {
     NSLog(@"Got some data: %@", parsedData);
    // currently we don't do anything with the data returned from
    // a post, so just pass it through
    // TODO: parse this into a model object
    return parsedData;
}

- (id)deserializeMarkResponseAsRead:(id)parsedData {
    NSLog(@"Got some data for marking response as read: %@", parsedData);
    // currently we don't do anything with the data returned from
    // a mark-as-read operation, so just pass it through
    // TODO: parse this into a model object
    return parsedData;
}

@end
