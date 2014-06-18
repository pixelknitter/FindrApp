//
//  FilterGroup.h
//  Findr
//
//  Created by Eddie Freeman on 6/17/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Filter.h"

@interface FilterGroup : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSArray *filters;
@property (nonatomic) BOOL isCollapsable;
@property (nonatomic) BOOL isExpandable;
@property (nonatomic) BOOL isCollapsed;
@property (nonatomic) int selectedRow;
@property (nonatomic) int rowsWhenCollapsed;
@property (nonatomic) BOOL hasMany;

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label filters:(NSArray *)filters isCollapsable:(BOOL)isCollapsable isCollapsed:(BOOL)isCollapsed isExpandable:(BOOL)isExpandable selectedRow:(int)selectedRow rowsWhenCollapsed:(int)rowsWhenCollapsed hasMany:(BOOL)hasMany;

- (void)toggleCollapsed:(int)selectedRow;
- (Filter *)getCurrentSelection;
- (NSInteger)displayRowsWhenCollapsed;

@end
