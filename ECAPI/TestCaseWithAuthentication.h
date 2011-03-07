//
//  TestCaseWithAuthentication.h
//  ECAPI
//
//  Created by Tony Hillerson on 2/2/11.
//  Copyright 2011 EffectiveUI. All rights reserved.
//

#import "ECSession.h"

// Extend this test case if you want an ECSession that is authenticated before running tests
@interface TestCaseWithAuthentication : GHAsyncTestCase<ECSessionAuthenticationDelegate> { }

@end
