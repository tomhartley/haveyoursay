//
//  THCreateArgumentController.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THCreateArgumentController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "THLoginManager.h"
#import "AJNotificationView.h"

@interface THCreateArgumentController ()

@end

@implementation THCreateArgumentController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petition:(THPetition *)petition
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pet = petition;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://parlihack.eu01.aws.af.cm/app/?r=argument/create&session=%@",[[THLoginManager sharedLoginManager]sessionID]]];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pet.petitionID, @"petition_id",
                            [NSString stringWithFormat:@"%d",positionSegmentedControl.selectedSegmentIndex], @"position",
                            userArgument.text, @"body",
                            @"0",@"rebuttal_id",
                            nil];
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:nil parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"success"] boolValue]) {
            NSLog(@"winning");
        } else {
            NSLog(@"%@",[JSON objectForKey:@"error"]);
        }
        [self dismiss:nil];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"%@",error);
    }];
    [operation start];

}
@end
