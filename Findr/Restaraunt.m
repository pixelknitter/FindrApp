//
//  Restaraunt.m
//  Findr
//
//  Created by Eddie Freeman on 6/13/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "Restaraunt.h"

@implementation Restaraunt

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"identifier"      : @"id",
           @"name"            : @"name",
           @"phoneNumber"     : @"display_phone",
           @"reviewCount"     : @"review_count",
           @"imageURL"        : @"image_url",
           @"snippet"         : @"snippet_text",
           @"sImageURL"       : @"snippet_image_url",
           @"displayAddress"  : @"location.display_address",
           @"rating"          : @"rating",
           @"ratingImageURL"  : @"rating_img_url",
           @"isClosed"        : @"is_closed",
           @"categories"      : @"categories",
           @"location"        : @"location"
           };
}

//+ (NSValueTransformer *)isClosedJSONTransformer {
//  NSDictionary *states = @{
//                           @"open": @(PlaceStateOpen),
//                           @"closed": @(PlaceStateClosed)
//                           };
//  
//  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
//    return states[str];
//  } reverseBlock:^(NSNumber *state) {
//    return [states allKeysForObject:state].lastObject;
//  }];
//}

+ (NSValueTransformer *)sImageURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)ratingImageURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageURLJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)displayAddressJSONTransformer {
  return [MTLValueTransformer transformerWithBlock:^(NSArray *addressParts) {
    return [[addressParts subarrayWithRange:NSMakeRange(0, [addressParts count] - 1)] componentsJoinedByString:@", "];
  }];
}

+ (NSValueTransformer *)categoriesJSONTransformer {
  return [MTLValueTransformer transformerWithBlock:^(NSArray *categories) {
    NSArray *filteredCategories = [[NSArray alloc] init];
    for (NSArray *category in categories) {
      filteredCategories = [filteredCategories arrayByAddingObject:category[0]];
    }
    return [filteredCategories componentsJoinedByString:@", "];
  }];
}

+ (NSArray *)placesWithArray:(NSArray *)array {
  NSError *error = nil;
  
  NSMutableArray *places = [[NSMutableArray alloc] init];
  for (NSDictionary *dictionary in array) {
    Restaraunt *place = [MTLJSONAdapter modelOfClass:[Restaraunt class] fromJSONDictionary:dictionary error:&error];
    if(!error) {
      [places addObject:place];
    } else {
      NSLog(@"%@", error);
    }
  }
  
  return places;

}

@end
