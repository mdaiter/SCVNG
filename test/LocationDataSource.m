//
//  LocationDataSource.m
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "LocationDataSource.h"
#import "LocationAutoCompleteObject.h"
#import <Underscore.m/Underscore.h>

@implementation LocationDataSource

-(id)init{
    self = [super init];
    if (self){
        [self setResults:[[NSArray alloc] init]];
    }
    return self;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        
        [local_search cancel];
        
        
        // Perform a new search.
        MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
        request.naturalLanguageQuery = string;
        request.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(37.785900, -122.406509), 20000, 20000);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        local_search = [[MKLocalSearch alloc] initWithRequest:request];
        
        [local_search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if (error != nil) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Map Error",nil)
                                            message:[error localizedDescription]
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
                return;
            }
            
            if ([response.mapItems count] == 0) {
                return;
            }
            
            [self setResults: [NSArray arrayWithArray:[self castLocationsToLocationAutoCompleteObject:response.mapItems]]];
            handler(_results);
        }];
    });
}

-(NSArray*)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
    possibleCompletionsForString:(NSString *)string{
    [self allPossibleLocationsWithString:string];
    return _results;
}

-(void) allPossibleLocationsWithString:(NSString*)search_string{
    [local_search cancel];
    
    
    // Perform a new search.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = search_string;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    local_search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [local_search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            //[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Map Error",nil)
            //                            message:[error localizedDescription]
            //                           delegate:nil
            //                  cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
            return;
        }
        
        if ([response.mapItems count] == 0) {
            return;
        }
        
        [self setResults: [NSArray arrayWithArray:[self castLocationsToLocationAutoCompleteObject:response.mapItems]]];
    }];
}

-(NSArray*)castLocationsToLocationAutoCompleteObject:(NSArray*)mapItems{
    return Underscore.array(mapItems)
            .map(^LocationAutoCompleteObject* (MKMapItem* map_item) {
                return [[LocationAutoCompleteObject alloc] initWithMapItem:map_item];
            })
            .unwrap;
}

@end
