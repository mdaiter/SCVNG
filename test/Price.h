//
//  Price.h
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum division_s{
    EACH,
    ALL
} division_t;

@interface Price : NSObject

@property (nonatomic) double price;

@property (nonatomic) division_t each_or_all;

-(id)initWithPrice:(double)price andDivisionType:(division_t)each_or_all;

@end
