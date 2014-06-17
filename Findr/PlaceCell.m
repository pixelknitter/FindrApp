//
//  PlaceCell.m
//  Findr
//
//  Created by Eddie Freeman on 6/13/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "PlaceCell.h"

@interface PlaceCell()

@end

@implementation PlaceCell

- (void)awakeFromNib
{
  // Initialization code
  [self.placeNameLabel setNumberOfLines:0];
  [self.placeNameLabel sizeToFit];
  
  [self.reviewCountLabel setNumberOfLines:0];
  [self.reviewCountLabel sizeToFit];
  
  [self.categoriesLabel setNumberOfLines:0];
  [self.categoriesLabel sizeToFit];
  
  [self.addressLabel setNumberOfLines:0];
  [self.addressLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  UIView *view = [[UIView alloc] initWithFrame:self.frame];
  view.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
  
  self.selectedBackgroundView = view;
  // Configure the view for the selected state
}

@end
