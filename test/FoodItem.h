//
//  FoodItem.h
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Price.h"

@interface FoodItem : NSObject

@property (strong, nonatomic) UIImage* food_image;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) NSString* units;

@property (nonatomic) NSInteger* quantity;

@property (nonatomic) Price* price;

-(id)initWithFoodImage:(UIImage*)food_image andTitle:(NSString*)title andUnits:(NSString*)units andQuantity:(NSInteger*)quantity andPrice:(Price*)price;

@end
