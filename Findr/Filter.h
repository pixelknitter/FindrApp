//
//  Filter.h
//  Findr
//
//  Created by Eddie Freeman on 6/17/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *label;
@property (nonatomic) BOOL enabled;
@property (nonatomic) NSString *apiValue;

- (id)initWithIdentifier:(NSString *)identifier label:(NSString *)label enabled:(BOOL)enabled apiValue:(NSString *)apiValue;

+ (NSArray *)buildFilterValuesWithArrayOfDictionaries:(NSArray *)rawFilterValues;

@end
