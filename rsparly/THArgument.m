//
//  THArgument.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THArgument.h"

@implementation THArgument

+(THArgument *)argumentWithDictionary:(NSDictionary *)d {
    THArgument *newArg = [[THArgument alloc] init];
    newArg.argumentID = [d objectForKey:@"id"];
    newArg.position = [[d objectForKey:@"position"] boolValue];
    newArg.body = [d objectForKey:@"body"];
    newArg.rebuttalID = [d objectForKey:@"rebuttal_id"];
    newArg.firstName = [d objectForKey:@"first_name"];
    newArg.lastname = [d objectForKey:@"last_name"];
    newArg.constituency = [d objectForKey:@"constituency_name"];
    newArg.votes = [[d objectForKey:@"votes"] intValue];
    return newArg;
}

@end
