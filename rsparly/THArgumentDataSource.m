//
//  THArgumentDataSource.m
//  rsparly
//
//  Created by Tom Hartley on 24/11/12.
//  Copyright (c) 2012 Tom Hartley. All rights reserved.
//

#import "THArgumentDataSource.h"
#import "THArgumentViewCell.h"
#import "THArgument.h"
#import <QuartzCore/QuartzCore.h>

@implementation THArgumentDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arguments count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    THArgumentViewCell *cell = (THArgumentViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    THArgument *argument = [self.arguments objectAtIndex:indexPath.row];
    cell.argumentTitle.text = [NSString stringWithFormat:@"%@ %@ from %@",argument.firstName, argument.lastname, argument.constituency];
    cell.argumentText.text = argument.body;
    cell.argumentText.numberOfLines = 0;
    switch (argument.position) {
        case YES: //they are for it, so green
            cell.colorView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
            break;
        default: //they're against it
            cell.colorView.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1];
            break;
    }
    if (argument.rebuttal) {
        cell.argumentRebutter.text = [NSString stringWithFormat:@"In rebuttal to %@ %@",argument.rebuttal.firstName,argument.rebuttal.lastname];
    }
    cell.colorView.layer.cornerRadius = 5;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(float)heightForRowAtIndexPath:(NSIndexPath *)path {
    THArgument *argument = [self.arguments objectAtIndex:path.row];
    CGSize sz = [argument.body sizeWithFont:[UIFont fontWithName:@"STHeitiSC-Light" size:16.0] constrainedToSize:CGSizeMake(400, 10000)]; //woo for magic numbers
    return sz.height+99;
}

-(UIColor *)colorForRowAtIndexPath:(NSIndexPath *)path {
    THArgument *argument = [self.arguments objectAtIndex:path.row];
    switch (argument.position) {
        case YES: //they are for it, so green
            return [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
            break;
        default: //they're against it
            return [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1];
            break;
    }
}

@end
