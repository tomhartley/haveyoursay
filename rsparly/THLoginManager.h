//
//  THLoginManager.h
//  rsparly
//
//  Created by Tom Hartley on 25/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THLoginManager : NSObject {
}


@property BOOL loggedIn;
@property NSString * sessionID;

+(THLoginManager *)sharedLoginManager;
-(void)createSessionWithEmail:(NSString *)email password:(NSString *)password;
-(void)logout;
@end
