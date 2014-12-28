//
//  SearchMapAnnotation.h
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SearchMapAnnotation : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* subtitle;

@property (nonatomic, strong) UIImageView* image;

@property (nonatomic, strong) NSString* food_title;

@property (nonatomic, strong) NSString* price;

@property (nonatomic, strong) UIButton* purchase;

@property (nonatomic, strong) NSString* bundle_method;
@property (nonatomic, strong) NSString* interval;
@property (nonatomic, strong) NSString* temp;
@property (nonatomic, strong) NSString* quantity;
@property (nonatomic, strong) NSString* units;


- (id)initWithLocation:(CLLocationCoordinate2D)coord;

-(MKAnnotationView*)annotationView;

-(id)initWithTitle:(NSString*)food_title andPrice:(NSString*)price andLocation:(CLLocationCoordinate2D)coord andBundleMethod:(NSString*)method andInterval:(NSString*)interval andTemp:(NSString*)temp andQuantity:(NSString*)quantity andUnits:(NSString*)units andImage:(UIImage*)image;

@end
