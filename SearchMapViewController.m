//
//  SearchMapViewControler.m
//  test
//
//  Created by Matthew Daiter on 8/5/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SearchMapViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SearchMapViewController ()

@end

@implementation SearchMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)zoomInit {
    MKUserLocation *userLocation = _map.userLocation;
    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 20000, 20000);
    [_map setRegion:region animated:NO];
}

-(void)search_button_click:(UITapGestureRecognizer*)recognizer{
    NSLog(@"Searching...");
    //Add search stuff
    
    
    /*[upwardView setFrame:CGRectMake(0, 265, 320, 230)];
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [animation setDuration:.50];
    [animation setDelegate:self];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CALayer *layer = [upwardView layer];
    [layer addAnimation:animation forKey:nil];
    [self.view.window addSubview:upwardView];*/

}

-(void)menu_button_click:(UITapGestureRecognizer*)recognizer{
    NSLog(@"Searching...");
    //Add search stuff
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"SearchMapView did load\n");
    _map.showsUserLocation = YES;
    [self zoomInit];
    // Do any additional setup after loading the view.
    
    [self addGestureRecognizerWithSelector:@selector(search_button_click:) direction:UISwipeGestureRecognizerDirectionDown toButton:self.search_button];
    
    [self addGestureRecognizerWithSelector:@selector(menu_button_click:) direction:UISwipeGestureRecognizerDirectionRight toButton:self.menu_button];
    
    //[self addGestureRecognizerWithSelector:@selector(sell_button_click:) direction:UISwipeGestureRecognizerDirectionLeft toButton:self.sell_button];
    
}

-(void)addGestureRecognizerWithSelector:(SEL)action direction:(UISwipeGestureRecognizerDirection)direction toButton:(UIButton*)button{
    UISwipeGestureRecognizer* swipe_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
    swipe_recognizer.direction = direction;
    button.userInteractionEnabled = YES;
    [button addGestureRecognizer:swipe_recognizer];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _map.centerCoordinate = userLocation.location.coordinate;
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
