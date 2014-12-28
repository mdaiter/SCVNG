//
//  SearchMapViewControler.h
//  test
//
//  Created by Matthew Daiter on 8/5/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CenterViewDelegate.h"
#import "SellCameraViewController.h"
#import "SearchMapSearchBarView.h"
#import "SearchMapAnnotation.h"

@interface SearchMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *search_button;

@property (strong, nonatomic) IBOutlet UIButton *menu_button;

@property (strong, nonatomic) IBOutlet UIButton *sell_button;

@property (strong, nonatomic) IBOutlet UIButton *scvng_button;

@property (strong, nonatomic) IBOutlet MKMapView* map;

@property (assign, nonatomic) UISearchBar* search_bar;

@property (strong, nonatomic) SearchMapSearchBarView *search_bar_search_view;

@property (strong, nonatomic) NSArray* annotation_handlers;

@property (weak, nonatomic) id <CenterViewDelegate> delegate;

-(IBAction)purchase:(id)sender;

@end
