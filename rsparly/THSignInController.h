//
//  THSignInController.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSignInController : UIViewController {
    
    __weak IBOutlet UITextField *emailText;
    __weak IBOutlet UITextField *passwordText;
}

- (IBAction)dismiss:(id)sender;
- (IBAction)login:(id)sender;
@end
