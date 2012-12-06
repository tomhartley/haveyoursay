//
//  THPetitionController.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THPetitionController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFJSONRequestOperation.h"
#import "THArgumentViewCell.h"
#import "THLoginManager.h"
#import "THCreateRebuttalController.h"
#import "THCreateArgumentController.h"
#import "AJNotificationView.h"

@interface THPetitionController ()

@end

@implementation THPetitionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petition:(THPetition *)petitionObj
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        petition = petitionObj;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleLabel.text = petition.title;
    descriptionTextView.text = petition.body;
    descriptionTextView.layer.cornerRadius = 5;
    descriptionTextView.layer.borderColor = [[UIColor colorWithWhite:0.5 alpha:1] CGColor];
    descriptionTextView.layer.borderWidth = 0;
    signatureCount.text = [NSString stringWithFormat:@"%d",petition.currentSignatures];
    departmentLabel.text = petition.department;
    dateProgress.progress = ([[NSDate date] timeIntervalSince1970]-[petition.startDate timeIntervalSince1970])/([petition.endDate timeIntervalSince1970] - [petition.startDate timeIntervalSince1970]);
    dateLabel.text = [NSString stringWithFormat:@"Petition expires in %d days",(int)floor([petition.endDate timeIntervalSinceDate:[NSDate date]]/(24*60*60))];
    
    [tableView registerNib:[UINib nibWithNibName:@"THArgumentViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    
    dataSource = [[THArgumentDataSource alloc] init];
    tableView.dataSource = dataSource;
    tableView.delegate = self;
    
    rf = [[UIRefreshControl alloc] init];
    [rf addTarget:self action:@selector(downloadArguments:) forControlEvents:UIControlEventValueChanged];
    rf.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [tableView addSubview:rf];
    [self downloadArguments:nil];
}

-(void)downloadArguments:(id)obj {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://parlihack.eu01.aws.af.cm/app/?r=petition/arguments&id=%@",petition.petitionID]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        dataSource.arguments = nil;
        NSArray *argumentDicts = (NSArray *) JSON;
        NSMutableArray *argumentObjects = [NSMutableArray array];
        for (NSDictionary *d in argumentDicts) {
            [argumentObjects addObject: [THArgument argumentWithDictionary:d]];
        }
        
        for (THArgument *a in argumentObjects) {
            if (![a.rebuttalID isEqualToString:@"0"]) {
                for (THArgument *argB in argumentObjects) {
                    if ([argB.argumentID isEqualToString:a.rebuttalID]) {
                        a.rebuttal = argB;
                    }
                }
            }
        }
        dataSource.arguments = argumentObjects;
        [tableView reloadData];
        [rf endRefreshing];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"%@",error);
        [rf endRefreshing];
    }];
    [operation start];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [dataSource heightForRowAtIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)aTableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger newRow = [[dataSource arguments] indexOfObject:[[[dataSource arguments] objectAtIndex:indexPath.row] rebuttal]];
    if (newRow!=NSNotFound) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:newRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        [tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:newRow inSection:0] animated:YES];
    }
    return NO;
}

-(IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNew:(id)sender {
    if ([[THLoginManager sharedLoginManager]loggedIn]) {
        THCreateArgumentController *c = [[THCreateArgumentController alloc] initWithNibName:@"THCreateArgumentController" bundle:nil petition:petition];
        c.modalPresentationStyle = UIModalPresentationFormSheet;
        c.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:c animated:YES completion:nil];
    } else {
        [AJNotificationView showNoticeInView:self.view
                                        type:AJNotificationTypeBlue
                                       title:@"You must be logged in to create an argument"
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:0.8f
                                      offset:0.0f
                                       delay:0.0f
                            detailDisclosure:NO
                                    response:nil];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
