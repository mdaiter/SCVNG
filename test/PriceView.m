//
//  PriceView.m
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "PriceView.h"

@implementation PriceView

-(void)setupEndDateTimePicker{
    //pick_each_or_all = [[UIPickerView alloc] init];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setShowing_pick_each_all:false];
        [self addSubview:[[[UINib nibWithNibName:@"PriceView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0]];
        self.price_field.delegate = self;
        [self setupEndDateTimePicker];
    }
    return self;
}

-(void)awakeFromNib{
    
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showing_pick_each_all = false;
        // Initialization code
        [self addSubview:[[[UINib nibWithNibName:@"PriceView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0]];
        [self setupEndDateTimePicker];
    }
    return self;
}

-(void)updatePriceWithString:(NSString*)selected_obj{
    if ([selected_obj isEqualToString:@"each"]){
        
        [self.price setEach_or_all:EACH];
    }
    else{
        [self.price setEach_or_all:ALL];
    }
}

-(void)updateTextFieldWithString:(NSString*)selected_obj{
    _price_field.text = selected_obj;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //Change if price tag changes
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
