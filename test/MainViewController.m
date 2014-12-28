//
//  MainViewController.m
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

#define SELL_CAMERA_VIEW_TAG 1
#define SEARCH_MAP_VIEW_TAG 2

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupMenu{
    self.delegate = self;
    [self addStylersFromArray:@[ [MSDynamicsDrawerParallaxStyler styler], [MSDynamicsDrawerShadowStyler styler] ] forDirection:MSDynamicsDrawerDirectionLeft];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.search_map_view_controller = (SearchMapViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"SearchMapView"];
    
    //self.user_view_controller = (UserViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"UserView"];

    self.swipe_view_controller = (SwipeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"SwipeViewController"];
    
    self.paneViewController = self.search_map_view_controller;
    
    self.main_menu_view_controller = (MainMenuTableViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    
    self.sell_camera_view_controller = (SellCameraViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"SellCameraView"];
    
    self.user_view_controller =(UserViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    
    [[self main_menu_view_controller] setDelegate:self];
    [[self search_map_view_controller] setDelegate:self];
    
    self.view_dict = @{@"SellCameraView": self.sell_camera_view_controller,
                       @"SwipeViewController" : self.swipe_view_controller,
                       @"SearchMapView" : self.search_map_view_controller,
                       @"UserViewController" : self.user_view_controller};
    
    
    [self setDrawerViewController:self.main_menu_view_controller forDirection:MSDynamicsDrawerDirectionLeft];
    
    [self setDrawerViewController:self.sell_camera_view_controller forDirection:MSDynamicsDrawerDirectionRight];

}


-(void)transitionToViewController:(NSString *)viewController withSender:(id)sender{
    NSLog(@"Hit here");
    [self setPaneViewController:self.view_dict[viewController] animated:YES completion:nil];
}


-(void)left_side:(id)sender{
    NSLog(@"Left side");
    [self setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

-(void)right_side:(id)sender{
    [self setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionRight animated:YES allowUserInterruption:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMenu];
    self.search_map_view_controller.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
