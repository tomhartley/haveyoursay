//
//  THPetition.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THPetition.h"

@implementation THPetition

+(THPetition *)petitionWithDictionary:(NSDictionary *)d {
    THPetition *newPetition = [[THPetition alloc] init];
    newPetition.petitionID = [d objectForKey:@"id"];
    newPetition.endDate = [NSDate dateWithTimeIntervalSince1970:[[d objectForKey:@"end_date"] intValue]];
    newPetition.startDate = [newPetition.endDate dateByAddingTimeInterval:-(365*24*60*60)];
    newPetition.body = [d objectForKey:@"description"];
    newPetition.title = [d objectForKey:@"title"];
    NSDictionary *department = [d objectForKey:@"department"];
    newPetition.department = [department objectForKey:@"name"];
    newPetition.currentSignatures = [[d objectForKey:@"signature_count"] intValue];
    return newPetition;
}

@end