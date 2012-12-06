//
//  THCreateArgumentController.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THPetition.h"

@interface THCreateArgumentController : UIViewController {
    
    __weak IBOutlet UISegmentedControl *positionSegmentedControl;
    __weak IBOutlet UITextView *userArgument;
    THPetition *pet;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petition:(THPetition *)petition;

- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;

@end
