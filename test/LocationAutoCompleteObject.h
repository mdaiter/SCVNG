//
//  LocationAutoCompleteObject.h
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MLPAutoCompleteTextField/MLPAutoCompletionObject.h>
#import <MapKit/MapKit.h>

@interface LocationAutoCompleteObject : NSObject <MLPAutoCompletionObject>

@property (strong, nonatomic) NSString* address;

@property (strong, nonatomic) NSString* title;

@property (strong, nonatomic) MKMapItem* map_item;

- (id)initWithTitle:(NSString *)title andAddress:(NSString*)address;

-(id)initWithMapItem:(MKMapItem*)mapItem;

@end
