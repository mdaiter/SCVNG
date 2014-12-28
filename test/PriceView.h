//
//  PriceView.h
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Price.h"

@interface PriceView : UIView <UITextFieldDelegate>{
}

@property (nonatomic, strong) IBOutlet UITextField* price_field;

@property (nonatomic, strong) IBOutlet UISegmentedControl* each_or_all;

//Set properties for what each property can be...

@property (nonatomic) BOOL showing_pick_each_all;

@property (nonatomic, strong) Price* price;

@end
