//
//  FoodItemView.m
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "FoodItemView.h"

@implementation FoodItemView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self addSubview:[[[UINib nibWithNibName:@"FoodItemView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0]];
        self.price_view = [[PriceView alloc] init];
    }
    NSLog(@"Hit initializing the food view");
    return self;
}

-(void)awakeFromNib{
    [self setupHotOrColdTint];
}

-(void)setupRoundedImage{
    self.image.layer.cornerRadius = self.image.frame.size.width / 2;
    self.image.clipsToBounds = YES;
    self.image.layer.borderWidth = 1.0f;
    self.image.layer.borderColor = [UIColor blueColor].CGColor;


}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[[[UINib nibWithNibName:@"FoodItemView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0]];
        // Initialization code
        self.price_view = [[PriceView alloc] init];
        [self setupRoundedImage];
        //init the hot or cold look
        [self setupHotOrColdTint];
    }
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.image.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)hideKeyboard{
    [self resignFirstResponder];
}

-(void)setupDismissiveKeyboard{
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    tapGesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGesture];
}

-(void)setupHotOrColdTint{
    [[[_hot_or_cold subviews] objectAtIndex:1] setTintColor:[UIColor redColor]];
    [[[_hot_or_cold subviews] objectAtIndex:0] setTintColor:[UIColor blueColor]];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:160/255.0f green:160/255.0f blue:160/255.0f alpha: 1].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, self.bounds.origin.x, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    CGContextClosePath(context);
    CGContextStrokePath(context);
}


@end
