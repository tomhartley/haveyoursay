//
//  THArgumentViewCell.h
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THArgumentViewCell : UITableViewCell {
    IBOutlet UIView *colorView;
    IBOutlet UILabel *argumentText;
    IBOutlet UILabel *argumentTitle;
    IBOutlet UILabel *argumentRebutter;
}

@property (nonatomic) UIView *colorView;
@property (nonatomic) UILabel *argumentText;
@property (nonatomic) UILabel *argumentTitle;
@property (nonatomic) UILabel *argumentRebutter;

@end
