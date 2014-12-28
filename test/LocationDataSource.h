//
//  LocationDataSource.h
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MLPAutoCompleteTextField/MLPAutoCompleteTextFieldDataSource.h>
#import <MapKit/MapKit.h>

@interface LocationDataSource : NSObject <MLPAutoCompleteTextFieldDataSource>{
    MKLocalSearch* local_search;
}

-(id)init;

@property (nonatomic, strong) NSArray* results;

@end
