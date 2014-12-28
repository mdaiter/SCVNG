//
//  UIUnderlinedButton.m
//  test
//
//  Created by Matthew Daiter on 8/16/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "UIUnderlinedButton.h"

@implementation UIUnderlinedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
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
