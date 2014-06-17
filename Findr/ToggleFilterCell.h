//
//  ToggleFilterCell.h
//  Findr
//
//  Created by Eddie Freeman on 6/16/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToggleFilterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;

@end
