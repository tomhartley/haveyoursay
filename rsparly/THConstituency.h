//
//  THConstituency.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface THConstituency : NSObject {
}
@property CLLocation* centerPoint;
@property NSString *name;
@property NSString *constituencyID;
@property NSArray *boundaryPoints;

@end
