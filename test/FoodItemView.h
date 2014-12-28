//
//  FoodItemView.h
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItem.h"
#import "PriceView.h"
#import "UnderlineTextField.h"
#import "PictureTakingView.h"

@interface FoodItemView : PictureTakingView <UITextFieldDelegate>

@property (nonatomic, strong) FoodItem* food_item;

//Make views that can get the appropriate data for the model

@property (nonatomic, strong) IBOutlet UIImageView* image;

@property (nonatomic, strong) IBOutlet UnderlineTextField* food_title;

@property (nonatomic, strong) IBOutlet UnderlineTextField* units;

@property (nonatomic, strong) IBOutlet UnderlineTextField* quantity;

@property (nonatomic, strong) IBOutlet UISegmentedControl* hot_or_cold;

@property (nonatomic, strong) IBOutlet PriceView* price_view;

@end
