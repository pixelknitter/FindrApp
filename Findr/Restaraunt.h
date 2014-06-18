//
//  Restaraunt.h
//  Findr
//
//  Created by Eddie Freeman on 6/13/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

typedef enum : NSUInteger {
  PlaceStateOpen,
  PlaceStateClosed
} PlaceState;

@interface Restaraunt : MTLModel <MTLJSONSerializing>

+ (NSArray *)placesWithArray:(NSArray *)array;

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *displayAddress;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSInteger reviewCount;
@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSUInteger rating;
@property (nonatomic, readonly) NSUInteger isClosed;
@property (nonatomic, readonly) NSUInteger isClaimed;
@property (nonatomic, readonly) NSURL *ratingImageURL;
@property (nonatomic, readonly) NSDictionary *location;
@property (nonatomic, readonly) NSString *snippet;
@property (nonatomic, readonly) NSURL *sImageURL;
@property (nonatomic, readonly) NSString *categories;

@end
