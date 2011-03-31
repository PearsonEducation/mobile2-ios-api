//
//  ECAuthenticatedFetcher.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest, ASIFormDataRequest;

@interface ECAuthenticatedFetcher : NSObject {
	ASIHTTPRequest *request;
	NSInteger responseStatusCode;
	NSDictionary *responseHeaders;
	NSMutableData *data;
	id delegate;
	SEL responseCallback, deserializeSelector;
	BOOL ignoreAuthentication;
}

@property(nonatomic,retain) NSDictionary *responseHeaders;
@property(nonatomic,assign) NSInteger responseStatusCode;
@property(nonatomic,assign) BOOL ignoreAuthentication;

+ (ASIHTTPRequest *) newAuthenticatedGETRequestWithURL:(NSURL *)earl;
+ (ASIFormDataRequest *) newAuthenticatedPOSTRequestWithURL:(NSURL *)earl;
+ (void)setGeneralDelegate:(id)delegateValue andSelector:(SEL)selectorValue;

- (id)initWithDelegate:(id)delegate responseSelector:(SEL)responseCallback;
- (void)loadDataFromURLString:(NSString *)urlString withDeserializationSelector:(SEL)deserializationSelector;
- (void)postParams:(NSDictionary *)params toURLFromString:(NSString *)urlString withDeserializationSelector:(SEL)deserializationSelector;
- (void) postBody:(NSDictionary*)body toURL:(NSString*)urlString withDeserializationSelector:(SEL)ds;
- (id)parseReturnedData;
- (void)cancel;
@end
