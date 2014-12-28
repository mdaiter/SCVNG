//
//  LocationAutoCompleteTableViewCell.m
//  test
//
//  Created by Matthew Daiter on 8/14/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "LocationAutoCompleteTableViewCell.h"

@implementation LocationAutoCompleteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
