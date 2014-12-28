//
//  SwipeView.m
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SwipeView.h"

@implementation SwipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithOptions:(MDCSwipeToChooseViewOptions *)options title:(NSString *)title quantity:(NSString *)quantity units:(NSString *)units price:(NSString *)price image:(UIImage *)image{
    
    self = [super initWithFrame:CGRectMake(0, 0, 320, 524) options:options];
    if (self){
        _title.text = title;
        _units.text = units;
        _price.text = price;
        _quantity.text = quantity;
        _image_view = [[UIImageView alloc] initWithImage:image];
    }
    return self;
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
