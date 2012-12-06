//
//  THMainMenuController.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THMainMenuController.h"

#import "THSignInController.h"

#import "THPetitionController.h"

#import "THPetition.h"
#import "THUser.h"

#import "AFJSONRequestOperation.h"

#import "THLoginManager.h"
#import "AJNotificationView.h"

@interface THMainMenuController ()

@end

@implementation THMainMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataSource = [[THPetitionsViewDataSource alloc] init];
    petitions.dataSource = dataSource;
    petitions.delegate = self;
    [petitions registerNib:[UINib nibWithNibName:@"THPetitionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mainCell"];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)petitions.collectionViewLayout;
    layout.itemSize = CGSizeMake(300, 200);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 40;
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    
    [self startSearch:@""];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    THPetition *p = [dataSource.petitions objectAtIndex:indexPath.item];
    THPetitionController *cont = [[THPetitionController alloc] initWithNibName:@"THPetitionController" bundle:nil petition:p];
    cont.modalPresentationStyle = UIModalPresentationFullScreen;
    cont.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:cont animated:YES completion:nil];
}

- (IBAction)signIn:(id)sender {
    if ([[THLoginManager sharedLoginManager] loggedIn]) {
        [[THLoginManager sharedLoginManager] logout];
        [AJNotificationView showNoticeInView:self.view
                                        type:AJNotificationTypeBlue
                                       title:@"Successfully signed out!"
                             linedBackground:AJLinedBackgroundTypeAnimated
                                   hideAfter:0.8f
                                      offset:0.0f
                                       delay:0.0f
                            detailDisclosure:NO
                                    response:nil];

    } else {
        THSignInController *s = [[THSignInController alloc] initWithNibName:@"THSignInController" bundle:nil];
        s.modalPresentationStyle = UIModalPresentationFormSheet;
        s.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:s animated:YES completion:nil];
    }
    [self updateLoginButton];
}

-(void)startSearch:(NSString *)search {
    NSURL *url;
    if (![search isEqualToString:@""]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://parlihack.eu01.aws.af.cm/app/index.php?r=petition/search&query=%@&n=10", search]];
    } else {
        url = [NSURL URLWithString:@"http://parlihack.eu01.aws.af.cm/app/index.php?r=petition/listtop&n=100"];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *petitionsDicts = (NSArray *) JSON;
        NSMutableArray *petitionObjects = [NSMutableArray array];
        for (NSDictionary *d in petitionsDicts) {
            [petitionObjects addObject: [THPetition petitionWithDictionary:d]];
        }
        dataSource.petitions = petitionObjects;
        [petitions reloadData];
        if (![search isEqualToString:@""]) {
            navBar.title = [NSString stringWithFormat:@"Search: %@",search];
        } else {
            navBar.title = @"Top Petitions";
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"%@",error);
    }];
    [operation start];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateLoginButton];
}

-(void)updateLoginButton {
    THLoginManager *loginManager = [THLoginManager sharedLoginManager];
    if ([loginManager loggedIn]) {
        navBar.leftBarButtonItem.title = @"Sign Out";
    } else {
        navBar.leftBarButtonItem.title = @"Sign In";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
