//
//  LocationAutoCompleteTextField.h
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UnderlineAutoCompleteTextField.h"
#import "LocationDataSource.h"

@interface LocationAutoCompleteTextField : UnderlineAutoCompleteTextField <MLPAutoCompleteTextFieldDelegate>

@property (nonatomic, strong) LocationDataSource* data_source;

@property (nonatomic, strong) CLLocation* curr_coords;

@end
