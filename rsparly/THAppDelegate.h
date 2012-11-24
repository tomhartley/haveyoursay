//
//  THAppDelegate.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THViewController;

@interface THAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) THViewController *viewController;

@end
