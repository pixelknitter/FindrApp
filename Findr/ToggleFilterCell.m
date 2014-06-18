//
//  ToggleFilterCell.m
//  Findr
//
//  Created by Eddie Freeman on 6/16/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "ToggleFilterCell.h"


@interface ToggleFilterCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

- (void)handleSwitchUpdate;

@end

@implementation ToggleFilterCell

- (void)awakeFromNib {
  [self.toggleSwitch addTarget:self action:@selector(handleSwitchUpdate) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)handleSwitchUpdate {
  self.filter.enabled = !self.filter.enabled;
}
- (void)setFilter:(Filter *)filter {
  _filter = filter;
  _nameLabel.text = filter.label;
  _toggleSwitch.on = filter.enabled;
}

@end
