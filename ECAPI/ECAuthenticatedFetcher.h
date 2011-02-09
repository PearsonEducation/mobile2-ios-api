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
	SEL responseCallback;
	id delegate;
}

@property(nonatomic,retain) NSDictionary *responseHeaders;
@property(nonatomic,assign) NSInteger responseStatusCode;

+ (ASIHTTPRequest *) newAuthenticatedGETRequestWithURL:(NSURL *)earl;
+ (ASIFormDataRequest *) newAuthenticatedPOSTRequestWithURL:(NSURL *)earl;

- (id) initWithDelegate:(id)delegate responseSelector:(SEL)responseCallback;
- (void) loadDataFromURLString:(NSString *)urlString;
- (void) postParams:(NSDictionary *)params toURLFromString:(NSString *)urlString;
- (void) dataDidFinishLoading;
- (void) informDelegateOfSuccess:(id)object;
- (void) cancel;

@end
