//
//  YelpManager.m
//  Findr
//
//  Created by Eddie Freeman on 6/16/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "YelpManager.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YelpManager()

@property (nonatomic, strong) YelpClient *client;

@end

@implementation YelpManager

- (FilterGroup *)getFilterGroupForSection:(int)section {
  return self.filterGroups[section];
}

- (id)init {
  self = [super init];
  if(self) {
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    NSArray *categoryFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                                  @{@"id": @"bakeries", @"enabled": @(NO), @"label": @"Bakeries", @"api_value": @"bakeries"},
                                                                                  @{@"id": @"beer_and_wine", @"label": @"Beer, Wine & Spirits", @"api_value": @"beer_and_wine"},
                                                                                  @{@"id": @"butcher", @"enabled": @(NO), @"label": @"Butcher", @"api_value": @"butcher"},
                                                                                  @{@"id": @"coffee", @"enabled": @(NO), @"label": @"Coffee & Tea", @"api_value": @"coffee"},
                                                                                  @{@"id": @"foodtrucks", @"enabled": @(NO), @"label": @"Food Trucks", @"api_value": @"foodtrucks"},
                                                                                  ]];
    NSArray *radiusFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                                @{@"id": @"2_blocks", @"enabled": @(NO), @"label": @"2 blocks", @"api_value": @"160"},
                                                                                @{@"id": @"6_blocks", @"enabled": @(NO), @"label": @"6 blocks", @"api_value": @"480"},
                                                                                @{@"id": @"1_miles", @"enabled": @(NO), @"label": @"1 mile", @"api_value": @"1609"},
                                                                                @{@"id": @"5_miles", @"enabled": @(NO), @"label": @"5 miles", @"api_value": @"8046"},
                                                                                ]];
    
    NSArray *otherFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                               @{@"id": @"deals", @"enabled": @(NO), @"label": @"Deals", @"api_value": @"1"},
                                                                               ]];
    
    NSArray *sortByFilters = [Filter buildFilterValuesWithArrayOfDictionaries:@[
                                                                                @{@"id": @"best_match", @"enabled": @(NO), @"label": @"Best Match", @"api_value": @"0"},
                                                                                @{@"id": @"distance", @"enabled": @(NO), @"label": @"Distance", @"api_value": @"1"},
                                                                                @{@"id": @"rating", @"enabled": @(NO), @"label": @"Rating", @"api_value": @"2"},
                                                                                ]
                              ];
    self.filterGroups = @[
                      [[FilterGroup alloc] initWithIdentifier:@"sort" label:@"Sort By" filters:sortByFilters isCollapsable:YES isCollapsed:YES isExpandable:YES selectedRow:0 rowsWhenCollapsed:1 hasMany:NO],
                      [[FilterGroup alloc] initWithIdentifier:@"radius_filter" label:@"Distance" filters:radiusFilters isCollapsable:YES isCollapsed:YES isExpandable:YES selectedRow:0 rowsWhenCollapsed:1 hasMany:NO],
                      [[FilterGroup alloc] initWithIdentifier:@"deals_filter" label:@"General Features" filters:otherFilters isCollapsable:NO isCollapsed:NO isExpandable:NO selectedRow:0 rowsWhenCollapsed:1 hasMany:YES],
                      [[FilterGroup alloc] initWithIdentifier:@"category_filter" label:@"Categories" filters:categoryFilters isCollapsable:NO isCollapsed:YES isExpandable:YES selectedRow:0 rowsWhenCollapsed:2 hasMany:YES],
                      ];
  }
  return self;
}

+ (instancetype)sharedManager {
  static id _sharedManager = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _sharedManager = [[self alloc] init];
  });
  
  return _sharedManager;
}

//- (RACSignal *)updateRestaurantList {
//  return [[self fetchRestaurantsWithTerm:_currentSearchTerm] doNext:^(NSArray *restaurants) {
//    [self setCurrentRestaurants:restaurants];
//  };
//}
//
//- (RACSignal *)fetchRestaurantsWithTerm:(NSString *)term {
//  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"term": term, @"location": @"San Francisco"}];
//  for (FilterGroup *filterGroup in _filterGroups) {
//    Filter *filter = [filterGroup getCurrentSelection];
//    parameters[filterGroup.identifier] = filter.apiValue;
//  }
//  NSLog(@"Search Parameters: %@", parameters);
//  return [[_client fetchJSONFromURL:parameters] map:^(NSDictionary *json) {
//    NSError *jsonError = nil;
//    NSArray *result = [MTLJSONAdapter modelsOfClass:[Restaurant class]
//                                      fromJSONArray:json[@"businesses"]
//                                              error:&jsonError];
//    if (jsonError) {
//      NSLog(@"JSON Error: %@", jsonError);
//    }
//    
//    return result;
//  }];
//}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term filters:(BOOL)updateFilters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"term": term, @"location": @"San Francisco"}];
  for (FilterGroup *filterGroup in self.filterGroups) {
    Filter *filter = [filterGroup getCurrentSelection];
    if(filter.enabled) {
      parameters[filterGroup.identifier] = filter.apiValue;
    }
  }
  NSLog(@"Search Parameters: %@", parameters);
  return [self.client fetchJSONFromURL:parameters success:success failure:failure];
}



@end
