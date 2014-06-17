//
//  FilterGroup.m
//  Findr
//
//  Created by Eddie Freeman on 6/17/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "FilterGroup.h"

@implementation FilterGroup

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label filters:(NSArray *)filters isCollapsable:(BOOL)isCollapsable isCollapsed:(BOOL)isCollapsed isExpandable:(BOOL)isExpandable selectedRow:(int)selectedRow rowsWhenCollapsed:(int)rowsWhenCollapsed hasMany:(BOOL)hasMany{
  self = [super init];
  if (self) {
    self.identifier = identifier;
    self.label = label;
    self.filters = filters;
    self.isCollapsable = isCollapsable;
    self.isCollapsed = isCollapsed;
    self.isExpandable = isExpandable;
    self.selectedRow = selectedRow;
    self.rowsWhenCollapsed = rowsWhenCollapsed;
    self.hasMany = hasMany;
  }
  return self;
}

- (void)toggleCollapsed:(int)selectedRow {
  if (self.isCollapsable) {
    self.isCollapsed = !self.isCollapsed;
    self.selectedRow = selectedRow;
  } else if (self.isExpandable && (selectedRow > (self.rowsWhenCollapsed - 1))) {
    self.isCollapsed = NO;
  }
}

- (Filter *)getCurrentSelection {
  return self.filters[self.selectedRow];
}

- (int)displayRowsWhenCollapsed {
  int rows = self.rowsWhenCollapsed;
  if (self.hasMany) {
    rows += 1;
  }
  return rows;
}

@end
