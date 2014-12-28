//
//  MainViewController.h
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MSDynamicsDrawerViewController/MSDynamicsDrawerViewController.h>
#import <MSDynamicsDrawerViewController/MSDynamicsDrawerStyler.h>
#import "SearchMapViewController.h"
#import "SellCameraViewController.h"
#import "MainMenuTableViewController.h"
#import "CenterViewDelegate.h"
#import "SwipeViewController.h"
#import "UserViewController.h"

@interface MainViewController : MSDynamicsDrawerViewController <MSDynamicsDrawerViewControllerDelegate, CenterViewDelegate>

@property (nonatomic, strong) MainMenuTableViewController* main_menu_view_controller;

@property (nonatomic, retain) SearchMapViewController* search_map_view_controller;

@property (nonatomic, retain) SellCameraViewController* sell_camera_view_controller;

@property (nonatomic, retain) SwipeViewController* swipe_view_controller;

@property (nonatomic, retain) UserViewController* user_view_controller;

@property (nonatomic, assign) BOOL showingCameraView;

@property (nonatomic, strong) NSDictionary* view_dict;

@end
