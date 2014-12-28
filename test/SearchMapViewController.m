//
//  SearchMapViewControler.m
//  test
//
//  Created by Matthew Daiter on 8/5/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SearchMapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "SearchMapAnnotation.h"
#import <CBTransaction.h>

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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 20000, 20000);
    [_map setRegion:region animated:NO];
}

-(void)search_button_click:(UITapGestureRecognizer*)recognizer{
    NSLog(@"Searching...");
    //Add search stuff
    
    
    [_search_bar setFrame:CGRectMake(0, 265, 320, 230)];
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    [animation setDuration:.50];
    [animation setDelegate:self];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    CALayer *layer = [_search_bar layer];
    [layer addAnimation:animation forKey:nil];
    [self.view.window addSubview:_search_bar];

}

-(void)sendTransaction:(NSNumber*)price{
    [CBTransaction send:@0.01 to:@"1JbwnNfJLU5PMVye4Qd89NHxtwCoSCZ1pZ" withNotes:@"CC" withHandler:^(CBTransaction *transaction, NSError *error) {
        
    }];
}

-(void)addTempPoints{
    SearchMapAnnotation* pin = [[SearchMapAnnotation alloc] initWithTitle:@"Pizza" andPrice:@"$1.50" andLocation:CLLocationCoordinate2DMake(0, 0) andBundleMethod:@"each" andInterval:@"30 mins" andTemp:@"hot" andQuantity:@"4" andUnits:@"slices" andImage:[UIImage imageNamed:@"pizza.png"]];
    [_map addAnnotation:pin];
}

-(IBAction)search_button_pressed:(id)sender{
    NSLog(@"Search clicked");
}

-(IBAction)add_button_clicked:(id)sender{
    [self.delegate right_side:self];
}

-(void)menu_button_click:(UITapGestureRecognizer*)recognizer{
    NSLog(@"Searching...");
    //Add search stuff
}

-(IBAction)menu_button_pressed:(id)sender{
    [self.delegate left_side:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"SearchMapView did load\n");
    _map.showsUserLocation = YES;
    [self zoomInit];
    [self retrieveNewDataPoints];
    self.map.delegate = self;
    [self addTempPoints];
    
    
    
    // Do any additional setup after loading the view.
    
}

-(void)addGestureRecognizerWithSelector:(SEL)action direction:(UISwipeGestureRecognizerDirection)direction toButton:(UIButton*)button{
    UISwipeGestureRecognizer* swipe_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
    swipe_recognizer.direction = direction;
    button.userInteractionEnabled = YES;
    [button addGestureRecognizer:swipe_recognizer];
    
}

-(IBAction)purchase:(id)sender{
    NSNumber *bitcoin = [NSNumber numberWithDouble:2.00/418.1];
    [self sendTransaction:bitcoin];
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

-(void)reloadAnnotations:(NSArray*)annotation_handlers{
    [_map removeAnnotations:[_map annotations]];
    for (PFObject* raw_obj in annotation_handlers){
        NSLog(@"");
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
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(location.latitude, location.longitude);
                SearchMapAnnotation* annotation = [[SearchMapAnnotation alloc] initWithTitle:title andPrice:price andLocation:coords andBundleMethod:bundle_method andInterval:interval andTemp:temp andQuantity:quantity andUnits:units andImage:image];
                [_map addAnnotation:annotation];
            }
        }];
    }
}

-(void)retrieveNewDataPoints{
    
    // do something with the new geoPoint
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:_map.centerCoordinate.latitude longitude:_map.centerCoordinate.longitude];
    // Create a query for places
    PFQuery *query = [PFQuery queryWithClassName:@"FoodSale"];
    // Interested in locations near user.
    [query whereKey:@"location" nearGeoPoint:userGeoPoint withinKilometers:0.6];
    // Limit what could be a lot of points.
    query.limit = 10;
    // Final list of objects
    _annotation_handlers = [query findObjects];
    //Put these in annotations
    [self reloadAnnotations:_annotation_handlers];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"Tapped");
    
}



/*-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[SearchMapAnnotation class]]){
        SearchMapAnnotation* search_map_annotation = (SearchMapAnnotation*) annotation;
        
        MKAnnotationView* annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"FoodAnnotation"];
        if (annotationView == nil){
            annotationView = search_map_annotation.annotationView;
        }
        else{
            annotationView.annotation = annotation;
        }
        UIButton* buy_button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = buy_button;
        //annotationView.image = search_map_annotation.image.image;
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        //annotationView.annotation = search_map_annotation;
        return search_map_annotation.annotationView;
    }
    else{
        return nil;
    }

}*/

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
