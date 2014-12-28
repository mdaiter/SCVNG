//
//  SwipeViewController.m
//  test
//
//  Created by Matthew Daiter on 9/3/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SwipeViewController.h"
#import <Parse/Parse.h>
#import "SwipeView.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MDCSwipeToChooseViewOptions* options = [[MDCSwipeToChooseViewOptions alloc] init];
    options.delegate = self;
    options.likedText = @"Buy";
    options.likedColor = [UIColor greenColor];
    options.nopeColor = [UIColor redColor];
    options.nopeText = @"Next";
    
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };

    [self setSwipe_view: [[MDCSwipeToChooseView alloc] initWithFrame:CGRectMake(0, 44, _swipe_view.bounds.size.width, _swipe_view.bounds.size.height) options:options]];
    
    [self.view addSubview:_swipe_view];
}

-(SwipeView*)makeNextSceneWithEndDate:(NSString*)interval andTemp:(NSString*)temp andQuantity:(NSString*)quantity andUnits:(NSString*)units andTitle:(NSString*)title andPrice:(NSString*)price andImage:(UIImage*)image{
    MDCSwipeToChooseViewOptions* options = [[MDCSwipeToChooseViewOptions alloc] init];
    options.delegate = self;
    options.likedText = @"Buy";
    options.likedColor = [UIColor greenColor];
    options.nopeColor = [UIColor redColor];
    options.nopeText = @"Next";
    
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    SwipeView* swipe_view = [[SwipeView alloc] init];
    swipe_view.units.text = units;
    swipe_view.imageView.image = image;
    swipe_view.price.text = price;
    swipe_view.quantity.text = quantity;
    swipe_view.title.text = title;

    return swipe_view;
}

- (NSString *)stringFromTimeIntervalDate:(NSString*)end_date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy, hh:mm a"];
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:end_date];
    
    
    NSDate *date_now = [NSDate date];
    
    NSTimeInterval secondsBetween = [date timeIntervalSinceDate:date_now];
    
    NSInteger ti = (NSInteger)secondsBetween;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

-(void)reloadMatches:(NSArray*)annotation_handlers{
    PFObject* raw_obj_head = [annotation_handlers objectAtIndex:[annotation_handlers count]];
    NSString* bundle_method = raw_obj_head[@"bundle_method"];
    
    //Here comes the big-ass date to string conversion
    NSString* end_date = raw_obj_head[@"end_date"];
    NSString* interval = [self stringFromTimeIntervalDate:end_date];
    NSString* temp = raw_obj_head[@"temperature"];
    NSString* quantity = raw_obj_head[@"quantity"];
    NSString* units = raw_obj_head[@"units"];
    NSString* title = raw_obj_head[@"title"];
    NSString* price = raw_obj_head[@"price"];
    PFGeoPoint* location = raw_obj_head[@"location"];
    PFFile* image = raw_obj_head[@"image"];
    UIImage* ui_image = [UIImage imageWithData:[image getData]];
    
    MDCSwipeToChooseViewOptions* options = [[MDCSwipeToChooseViewOptions alloc] init];
    options.delegate = self;
    options.likedText = @"Buy";
    options.likedColor = [UIColor greenColor];
    options.nopeColor = [UIColor redColor];
    options.nopeText = @"Next";
    
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    SwipeView* swipe_view_tail = [[SwipeView alloc] initWithOptions:options title:title quantity:quantity units:units price:price image:ui_image];

    
    
    
    for (NSUInteger i = [annotation_handlers count]; i > -1; i--){
        PFObject* raw_obj = (PFObject*)[annotation_handlers objectAtIndex:i];
        NSString* bundle_method = raw_obj[@"bundle_method"];
        
        //Here comes the big-ass date to string conversion
        NSString* end_date = raw_obj[@"end_date"];
        NSString* interval = [self stringFromTimeIntervalDate:end_date];
        NSString* temp = raw_obj[@"temperature"];
        NSString* quantity = raw_obj[@"quantity"];
        NSString* units = raw_obj[@"units"];
        NSString* title = raw_obj[@"title"];
        NSString* price = raw_obj[@"price"];
        PFGeoPoint* location = raw_obj[@"location"];
        PFFile* image = raw_obj[@"image"];
        UIImage* ui_image = [UIImage imageWithData:[image getData]];
        SwipeView* swipe_view = [[SwipeView alloc] initWithOptions:options title:title quantity:quantity units:units price:price image:ui_image];
    }
}

-(void)retrieveNewDataPoints{
    
    // do something with the new geoPoint
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            // do something with the new geoPoint
            PFQuery *query = [PFQuery queryWithClassName:@"FoodSale"];
            // Interested in locations near user.
            [query whereKey:@"location" nearGeoPoint:geoPoint withinKilometers:0.6];
            // Limit what could be a lot of points.
            query.limit = 10;
            // Final list of objects
            NSArray* objects = [query findObjects];
            //Put these in annotations

        }
    }];
    // Create a query for places
}

- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
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
