//
//  SellCameraViewController.m
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SellCameraViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Underscore+Functional.h>
#import <Parse/Parse.h>
#import "PriceView.h"

#define FOOD_TITLE_TAG 0
#define LOCATION_TAG 1
#define END_DATE_TAG 2
#define PRICE_TAG 3

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@interface SellCameraViewController ()

@end

@implementation SellCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.selected_from_camera_view.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction)addNewFoodItem:(id)sender{
    NSLog(@"Adding new food item");
    [UIView animateWithDuration:0.2 animations:^(void){
        //Move everything down a place
        
        [[self scroll_view_container] setFrame:CGRectMake([self scroll_view_container].frame.origin.x, [self scroll_view_container].frame.origin.y, [self scroll_view_container].frame.size.width, [self scroll_view_container].frame.size.height + 260.0)];
        
        self.scroll_view.contentSize = CGSizeMake(267, [self scroll_view_container].frame.size.height);
        
        for (FoodItemView* food_item in food_item_views){
            [food_item setFrame:CGRectMake([food_item frame].origin.x, [food_item frame].origin.y + 260.0, [food_item frame].size.width, [food_item frame].size.height)];
        }
        
        [_send_button setFrame:CGRectMake(_send_button.frame.origin.x, [self.send_button frame].origin.y + 260.0, _send_button.frame.size.width,_send_button.frame.size.height)];
        
        NSLog(@"%f %f %f %f %f", [self.send_button frame].origin.x, [self.send_button frame].origin.y, [self.send_button frame].size.width, [self.send_button frame].size.height, [[self scroll_view_container] frame].size.height);

        
        
        //Add an item with the appropriate frame
        FoodItemView* new_food_item = [[FoodItemView alloc] initWithFrame:CGRectMake(0.0, 388.0, 267.0, 260.0)];
        //TAKE THIS OUT AFTER THE NEW ONE
        [[new_food_item image] setImage:[UIImage imageNamed:@"pizza.png"]];
        
        [food_item_views addObject:new_food_item];
        
        [[self scroll_view_container] addSubview:new_food_item];
    }];
}

-(void)setupPriceInput{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    self.price.text = [numberFormatter stringFromNumber:[NSNumber numberWithInt:0]];
}

-(void)setupEndDateTimePicker{
    end_time_picker = [[UIDatePicker alloc] init];
    end_time_picker.datePickerMode = UIDatePickerModeDateAndTime;
    [end_time_picker addTarget:self action:@selector(endDateValueChanged) forControlEvents:UIControlEventValueChanged];

}

-(void)setupFirebase{
    Firebase* firebase = [[Firebase alloc] initWithUrl:@"https://boiling-inferno-3311.firebaseio.com"];
    _geo_fire = [[GeoFire alloc] initWithFirebaseRef:firebase];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    food_item_views = [[NSMutableArray alloc] init];
    [self setupEndDateTimePicker];
    [self addNewFoodItem:self];
    [self presentCamera];
    [self setupKeyboard];
    [self setupPriceInput];
    [self setupDismissiveKeyboard];
    
    CGAffineTransform rotateTransform = CGAffineTransformRotate(CGAffineTransformIdentity,
                                                                RADIANS(-45.0));
    _send_button.transform = rotateTransform;
    _send_button.clipsToBounds = YES;
}

-(void)setupScrollView{
    //[self.scroll_view addSubview:self.scroll_view_container];
    self.scroll_view.contentSize = CGSizeMake(267, 450);
    self.scroll_view.frame = CGRectMake(53, 0, 267, 568);
    self.scroll_view.scrollEnabled = YES;
    
}

-(void)adjustTransparencyOfUIFields:(BOOL)in{
    NSLog(@"Active field tag: %ld", (long)self.active_field.tag);
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGFloat alpha;
                         if (in){
                             alpha = 0;
                         }
                         else{
                             alpha = 1;
                         }
                         switch (self.active_field.tag){
                             case FOOD_TITLE_TAG: {
                                 [self.location setAlpha:alpha];
                                 [self.price setAlpha:alpha];
                                 [self.end_date setAlpha:alpha];
                                 [self.divisible setAlpha:alpha];
                                 break;
                             }
                             case LOCATION_TAG: {
                                 [self.food_title setAlpha:alpha];
                                 [self.price setAlpha:alpha];
                                 [self.end_date setAlpha:alpha];
                                 [self.divisible setAlpha:alpha];
                                 break;
                             }
                             case END_DATE_TAG: {
                                 [self.location setAlpha:alpha];
                                 [self.price setAlpha:alpha];
                                 [self.food_title setAlpha:alpha];
                                 [self.divisible setAlpha:alpha];
                                 break;

                             }
                             case PRICE_TAG: {
                                 [self.location setAlpha:alpha];
                                 [self.food_title setAlpha:alpha];
                                 [self.end_date setAlpha:alpha];
                                 [self.divisible setAlpha:alpha];
                                 break;
                             }
                         }
                         
                     } completion:^(BOOL finished){
                         
                     }];
    
}

-(void)hideKeyboard{
    [self.active_field resignFirstResponder];
}

-(void)setupDismissiveKeyboard{
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    tapGesture.cancelsTouchesInView = NO;
    [self.scroll_view addGestureRecognizer:tapGesture];
}

- (void) keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scroll_view.contentInset = contentInsets;
    self.scroll_view.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    
    //Switch based on whihc active field is open
    if (!CGRectContainsPoint(aRect, self.active_field.frame.origin) || !CGRectContainsPoint(aRect, CGPointMake(self.active_field.frame.size.width + self.active_field.frame.origin.x, self.active_field.frame.size.height + self.active_field.frame.origin.y) ) ) {
        //Here we need to set what goes transparent or not
        [self adjustTransparencyOfUIFields:true];
        switch (self.active_field.tag) {
            case LOCATION_TAG: {
                NSInteger offset_table_view = 43 * 3 /*Height of table cells*/ - 4; /*Little bit of padding*/
                        
                CGPoint scroll_point = CGPointMake(0.0, self.active_field.frame.origin.y-kbSize.height + offset_table_view);
                //Make scroll point equal to the scroll point + table view
                [self.scroll_view setContentOffset:scroll_point animated:YES];
                
                break;
            }
    
            default: {
                //Here we need to set what goes transparent or not
                CGPoint scroll_point = CGPointMake(0.0, self.active_field.frame.origin.y-kbSize.height);
                [self.scroll_view setContentOffset:scroll_point animated:YES];
                break;
            }
        }
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroll_view.contentInset = contentInsets;
    self.scroll_view.scrollIndicatorInsets = contentInsets;
    [self adjustTransparencyOfUIFields:false];
}

//Autoformat for price field
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //Change if price tag changes
    if (textField.tag == PRICE_TAG){
        NSInteger MAX_DIGITS = 11; // $999,999,999.99
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setMaximumFractionDigits:2];
        [numberFormatter setMinimumFractionDigits:2];
        
        NSString *stringMaybeChanged = [NSString stringWithString:string];
        if (stringMaybeChanged.length > 1)
        {
            NSMutableString *stringPasted = [NSMutableString stringWithString:stringMaybeChanged];
            
            [stringPasted replaceOccurrencesOfString:numberFormatter.currencySymbol
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [stringPasted length])];
            
            [stringPasted replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [stringPasted length])];
            
            NSDecimalNumber *numberPasted = [NSDecimalNumber decimalNumberWithString:stringPasted];
            stringMaybeChanged = [numberFormatter stringFromNumber:numberPasted];
        }
        
        UITextRange *selectedRange = [textField selectedTextRange];
        UITextPosition *start = textField.beginningOfDocument;
        NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
        NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
        NSUInteger textFieldTextStrLength = textFieldTextStr.length;
        
        [textFieldTextStr replaceCharactersInRange:range withString:stringMaybeChanged];
        
        [textFieldTextStr replaceOccurrencesOfString:numberFormatter.currencySymbol
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [textFieldTextStr length])];
        
        [textFieldTextStr replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [textFieldTextStr length])];
        
        [textFieldTextStr replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [textFieldTextStr length])];
        
        if (textFieldTextStr.length <= MAX_DIGITS)
        {
            NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
            NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
            NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
            NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
            
            textField.text = textFieldTextNewStr;
            
            if (cursorOffset != textFieldTextStrLength)
            {
                NSInteger lengthDelta = textFieldTextNewStr.length - textFieldTextStrLength;
                NSInteger newCursorOffset = MAX(0, MIN(textFieldTextNewStr.length, cursorOffset + lengthDelta));
                UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
                UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
                [textField setSelectedTextRange:newRange];
            }
        }
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)setupKeyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)endDateValueChanged{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //[dateFormatter setDateFormat:@"MMM d, yyyy"];
    _end_date.text = [dateFormatter stringFromDate:[end_time_picker date]];
}

-(IBAction)textFieldDidBeginEditing:(id)sender{
    self.active_field = sender;
    switch (self.active_field.tag){
        case END_DATE_TAG: {
            //datePicker.tag = indexPath.row;
            self.active_field.inputView = self->end_time_picker;

        }
        default: {
            break;
        }
    }
}

-(IBAction)textFieldDidEndEditing:(id)sender{
    self.active_field = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearAll{
    for (FoodItemView* food_item in food_item_views){
        food_item.image.image = nil;
        food_item.food_title.text = @"";
        food_item.units.text = @"";
        food_item.quantity.text = @"";
        _end_date.text = @"";
        food_item.price_view.price_field.text = @"";
    }
    
}

-(IBAction)upload:(id)sender{
    NSLog(@"Uploading...");
    //Fill up object with food order
    
    for (FoodItemView* food_item in food_item_views){
        //Need to upload image first
        NSData* data = UIImagePNGRepresentation(food_item.image.image);
        //Make a string
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hhmmMMddyy"];
        
        PFFile* image_upload = [PFFile fileWithName:[food_item.food_title.text stringByAppendingString:[formatter stringFromDate:[NSDate date]]] data:data];
        [image_upload saveInBackground];
        
        PFObject* food_order = [PFObject objectWithClassName:@"FoodSale"];
        food_order[@"title"] = food_item.food_title.text;
        food_order[@"units"] = food_item.units.text;
        
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        food_order[@"quantity"] = [f numberFromString:food_item.quantity.text];
        
        food_order[@"end_date"] = _end_date.text;

        switch (food_item.hot_or_cold.selectedSegmentIndex){
            case 0:
                food_order[@"temperature"] = @"hot";
                break;
            case 1:
                food_order[@"temperature"] = @"cold";
                break;
        }
        
        switch (food_item.price_view.each_or_all.selectedSegmentIndex) {
            case 0:
                food_order[@"bundle_method"] = @"each";
                break;
            case 1:
                food_order[@"bundle_method"] = @"for_all";
                break;
            default:
                break;
        }
        
        food_order[@"price"] = food_item.price_view.price_field.text;
        food_order[@"image"] = image_upload;
        if (![_location.text  isEqual: @""]){
            food_order[@"location"] = [PFGeoPoint geoPointWithLatitude:_location.curr_coords.coordinate.latitude longitude:_location.curr_coords.coordinate.longitude];
        }
        else{
            [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
                if (!error) {
                    // do something with the new geoPoint
                    food_order[@"location"] = geoPoint;
                }
            }];
        }
        
        [food_order saveInBackground];
        
    }
    [self clearAll];
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
