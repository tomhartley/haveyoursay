//
//  THArgument.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THUser.h"
#import "THPetition.h"

@interface THArgument : NSObject {
}
@property NSString *argumentID;
@property NSString *body;
@property NSString *firstName;
@property NSString *lastname;
@property NSString *constituency;
@property int votes;
@property NSString *rebuttalID;
@property THArgument *rebuttal;
@property BOOL position; //YES is for, NO is against
@property BOOL upvoted;

+(THArgument *)argumentWithDictionary:(NSDictionary *)d;

@end
