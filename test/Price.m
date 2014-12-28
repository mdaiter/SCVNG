//
//  Price.m
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "Price.h"

@implementation Price

-(id)initWithPrice:(double)price andDivisionType:(division_t)each_or_all{
    self = [super init];
    if (self){
        [self setPrice:price];
        [self setEach_or_all:each_or_all];
    }
    return self;
}

@end
