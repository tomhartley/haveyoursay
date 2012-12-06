//
//  THPetitionsViewDataSource.m
//  ;
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THPetitionsViewDataSource.h"
#import "THPetition.h"

@implementation THPetitionsViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.petitions count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THPetitionViewCell *cell = (THPetitionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    //configure cell for usage
    cell.signatures.text = [NSString stringWithFormat:@"%d",[[self.petitions objectAtIndex:indexPath.row] currentSignatures]];
    cell.title.text = [[self.petitions objectAtIndex:indexPath.row] title];
    return cell;
}

@end
