//
//  LogInTestCase.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/1/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"

@interface AuthenticationTestCase : GHTestCase<ECSessionAuthenticationDelegate> {
	ECSession *session;
	BOOL authenticationTestCompleted;
}

- (void) testAuthentication;

@end
