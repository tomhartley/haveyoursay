//
//  THPetitionController.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THPetition.h"
#import "THArgumentDataSource.h"

@interface THPetitionController : UIViewController <UITableViewDelegate> {
    THPetition *petition;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *departmentLabel;
    __weak IBOutlet UIProgressView *dateProgress;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UITextView *descriptionTextView;
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UILabel *signatureCount;
    THArgumentDataSource *dataSource;
    UIRefreshControl *rf;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petition:(THPetition *)petitionObj;
- (IBAction)dismiss:(id)sender;
- (IBAction)addNew:(id)sender;
@end
