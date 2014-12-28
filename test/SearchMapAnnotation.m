//
//  SearchMapAnnotation.m
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SearchMapAnnotation.h"
#import <CBTransaction.h>

@implementation SearchMapAnnotation

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        [self setCoordinate:coord];
    }
    return self;
}

-(void)sendTransaction{
    [CBTransaction send:@0.01 to:@"1JbwnNfJLU5PMVye4Qd89NHxtwCoSCZ1pZ" withNotes:@"CC" withHandler:^(CBTransaction *transaction, NSError *error) {
        
    }];
}


-(id)initWithTitle:(NSString *)food_title andPrice:(NSString *)price andLocation:(CLLocationCoordinate2D)coord andBundleMethod:(NSString *)method andInterval:(NSString *)interval andTemp:(NSString *)temp andQuantity:(NSString *) quantity andUnits:(NSString *)units andImage:(UIImage *)image{
    self = [super init];
    if (self) {
        [self setCoordinate:coord];
        [self setFood_title:food_title];
        [self setPrice:price];
        [self setImage:[[UIImageView alloc] initWithImage:image] ];
        [self setBundle_method:method];
        [self setInterval:interval];
        [self setTemp:temp];
        [self setQuantity:quantity];
        [self setUnits:units];
        
        [self setPurchase:[UIButton buttonWithType:UIButtonTypeContactAdd]];
        
        self.purchase = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [self.purchase addTarget:self action:@selector(sendTransaction) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;

}

-(NSString*)title{
    
    return _food_title;
    //return [_quantity stringByAppendingString:
    //        [@" " stringByAppendingString:[_temp stringByAppendingString:[@" "
      //                                                                    stringByAppendingString:[_units stringByAppendingString:[@" of " stringByAppendingString:_food_title]]]]]];
}

-(NSString*)subtitle{
    return [@"Until " stringByAppendingString:_interval];
    //return [@"Until " stringByAppendingString:_interval];
}

-(MKAnnotationView*)annotationView{
    MKAnnotationView* annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"FoodAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    //annotationView.leftCalloutAccessoryView = _image;
    annotationView.rightCalloutAccessoryView = _purchase;
    
    return annotationView;
}

@end
