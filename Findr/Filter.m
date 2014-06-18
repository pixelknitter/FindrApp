//
//  Filter.m
//  Findr
//
//  Created by Eddie Freeman on 6/17/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "Filter.h"

@implementation Filter

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label enabled:(BOOL)enabled apiValue:(NSString *)apiValue {
  self = [super init];
  if (self) {
    self.identifier = identifier;
    self.label = label;
    self.enabled = enabled;
    self.apiValue = apiValue;
  }
  return self;
}

+ (NSArray *)buildFilterValuesWithArrayOfDictionaries:(NSArray *)rawFilterValues {
  NSArray *filterValues = [[NSArray alloc] init];
  for (NSDictionary *filterDict in rawFilterValues) {
    Filter *filter = [[Filter alloc] initWithIdentifier:filterDict[@"id"] label:filterDict[@"label"] enabled:[filterDict[@"enabled"] boolValue] apiValue:filterDict[@"api_value"]];
    filterValues = [filterValues arrayByAddingObject:filter];
  }
  return filterValues;
}

@end
