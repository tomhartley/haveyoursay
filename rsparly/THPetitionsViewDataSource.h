//
//  THPetitionsViewDataSource.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THPetitionViewCell.h"

@interface THPetitionsViewDataSource : NSObject <UICollectionViewDataSource> {
}

@property (nonatomic) NSArray *petitions;

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;


@end
