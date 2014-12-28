//
//  SellCameraViewController.h
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlineTextField.h"
#import "LocationAutoCompleteTextField.h"
#import "LocationDataSource.h"
#import "FoodItemView.h"
#import "PictureTakingViewController.h"
#import <GeoFire/GeoFire.h>

@interface SellCameraViewController : PictureTakingViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>{
    UIDatePicker* end_time_picker;
    NSMutableArray* food_item_views;
}

@property (strong, nonatomic) IBOutlet UIImageView* selected_from_camera_view;

@property (assign, nonatomic) IBOutlet UIScrollView* scroll_view;

@property (strong, nonatomic) IBOutlet UIView* scroll_view_container;

@property (strong, nonatomic) IBOutlet UISwitch* divisible;

@property (strong, nonatomic) IBOutlet UnderlineTextField* food_title;

@property (weak) IBOutlet LocationAutoCompleteTextField* location;

@property (strong, nonatomic) GeoFire* geo_fire;

@property (strong, nonatomic) IBOutlet LocationDataSource* data_source;

@property (strong, nonatomic) IBOutlet UnderlineTextField* end_date;

@property (strong, nonatomic) IBOutlet UnderlineTextField* price;

@property (weak, nonatomic) UnderlineTextField* active_field;

@property (strong, nonatomic) IBOutlet UIButton* send_button;

-(IBAction)addNewFoodItem:(id)sender;

@end
