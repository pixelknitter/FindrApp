//
//  YelpManager.h
//  Findr
//
//  Created by Eddie Freeman on 6/16/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpClient.h"
#import "FilterGroup.h"

@interface YelpManager : NSObject

@property (nonatomic, strong) NSString *currentSearchTerm;
@property (nonatomic, strong) NSArray *currentRestaurants;
@property (nonatomic, strong) NSArray *filterGroups;
@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic) BOOL updateFilters;


- (FilterGroup *)getFilterGroupForSection:(int)section;

+ (instancetype)sharedManager;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term filters:(BOOL)updateFilters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
