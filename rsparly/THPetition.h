//
//  THPetition.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THArgument.h"

@interface THPetition : NSObject {
}

@property NSString *petitionID;
@property NSDate *startDate;
@property NSDate *endDate;
@property NSString *title;
@property NSString *body;
@property NSString *department;
@property NSArray *arguments;
@property int currentSignatures;

+(THPetition *)petitionWithDictionary:(NSDictionary *)d;

@end
