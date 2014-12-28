//
//  LocationAutoCompleteTextField.m
//  test
//
//  Created by Matthew Daiter on 8/13/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "LocationAutoCompleteTextField.h"
#import "LocationAutoCompleteObject.h"
#import "LocationAutoCompleteTableViewCell.h"

@implementation LocationAutoCompleteTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.autoCompleteDataSource = _data_source;
        //[self registerAutoCompleteCellClass:[LocationAutoCompleteTableViewCell class] forCellReuseIdentifier:@"CustomCell"];
        [self setBorderStyle:UITextBorderStyleBezel];
        self.autoCompleteDelegate = self;
    }
    return self;
}

-(BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
         shouldConfigureCell:(UITableViewCell *)cell
      withAutoCompleteString:(NSString *)autocompleteString
        withAttributedString:(NSAttributedString *)boldedString
       forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
           forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationAutoCompleteObject* auto_obj = autocompleteObject;
    cell.detailTextLabel.text = auto_obj.map_item.placemark.addressDictionary[@"Street"];
    _curr_coords = [[CLLocation alloc] initWithLatitude:auto_obj.map_item.placemark.coordinate.latitude longitude:auto_obj.map_item.placemark.coordinate.longitude];
    NSLog(@"%@", cell.detailTextLabel.text);
    return YES;
}

-(void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
        didSelectAutoCompleteString:(NSString *)selectedString
        withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
        forRowAtIndexPath:(NSIndexPath *)indexPath{
    self.text = selectedString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
