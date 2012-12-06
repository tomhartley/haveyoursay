//
//  THArgumentDataSource.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THArgumentDataSource : NSObject <UITableViewDataSource>

@property NSArray *arguments;

-(float)heightForRowAtIndexPath:(NSIndexPath *)path;
-(UIColor *)colorForRowAtIndexPath:(NSIndexPath *)path;

@end
