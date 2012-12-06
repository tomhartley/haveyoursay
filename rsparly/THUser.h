//
//  THUser.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THConstituency.h"

@interface THUser : NSObject {
}
@property NSString *userID;
@property NSString *email;
@property NSString *password;
@property THConstituency *constituency;
@property NSString *firstName;
@property NSString *surname;
@property NSString *initial;
@end
