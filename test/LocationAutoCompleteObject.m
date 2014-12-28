//
//  LocationAutoCompleteObject.m
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "LocationAutoCompleteObject.h"

@implementation LocationAutoCompleteObject

-(id)initWithTitle:(NSString *)title andAddress:(NSString *)address{
    self = [super init];
    if (self){
        [self setTitle:title];
        [self setAddress:address];
    }
    return self;
}

-(id)initWithMapItem:(MKMapItem *)mapItem{
    self = [super init];
    if (self){
        [self setTitle:mapItem.name];
        [self setAddress:mapItem.placemark.addressDictionary[@"Street"]];
        [self setMap_item:mapItem];
    }
    return self;
}

-(NSString*)autocompleteString{
    return self.title;
}

@end
