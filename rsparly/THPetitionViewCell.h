//
//  THPetitionViewCell.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THPetitionViewCell : UICollectionViewCell {
    IBOutlet UILabel *title;
    IBOutlet UILabel *signatures;
}

@property (nonatomic) UILabel *title;
@property (nonatomic) UILabel *signatures;

@end
