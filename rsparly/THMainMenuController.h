//
//  THMainMenuController.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THPetitionsViewDataSource.h"

@interface THMainMenuController : UIViewController <UICollectionViewDelegate>{
    IBOutlet UICollectionView *petitions;
    THPetitionsViewDataSource *dataSource;
    IBOutlet UINavigationItem *navBar;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)startSearch:(NSString *)search;
- (IBAction)signIn:(id)sender;

@end
