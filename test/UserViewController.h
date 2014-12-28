//
//  UserViewController.h
//  test
//
//  Created by Matthew Daiter on 9/2/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievementView.h"

@interface UserViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UILabel* name;

@property (nonatomic, strong) IBOutlet UILabel* sales;

@property (nonatomic, strong) IBOutlet UILabel* purchases;

@property (nonatomic, strong) IBOutlet UITextField* bitcoin_address;

@property (nonatomic, strong) IBOutlet UIImageView* profile_image;

@property (nonatomic, strong) NSMutableArray* achievement_views;

@end
