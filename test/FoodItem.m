//
//  FoodItem.m
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "FoodItem.h"

@implementation FoodItem

-(id)initWithFoodImage:(UIImage *)food_image andTitle:(NSString *)title andUnits:(NSString *)units andQuantity:(NSInteger *)quantity andPrice:(Price *)price{
    self = [super init];
    if (self){
        [self setPrice:price];
        [self setQuantity:quantity];
        [self setTitle:title];
        [self setFood_image:food_image];
        [self setUnits:units];
    }
    return self;
}

@end
