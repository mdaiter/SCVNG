//
//  SearchMapSearchBarView.m
//  test
//
//  Created by Matthew Daiter on 8/11/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "SearchMapSearchBarView.h"

#define SEARCH_VIEW_OPEN_HEIGHT 425
#define SEARCH_VIEW_OPEN_Y 143

#define SEARCH_VIEW_CLOSED_HEIGHT 0
#define SEARCH_VIEW_CLOSED_Y 568



@implementation SearchMapSearchBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Specify translucence parameters
        self.translucentAlpha = 0.7;
        self.translucentTintColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.translucentStyle = UIBarStyleDefault;
    }
    return self;
}

-(void)show{
    [UIView animateWithDuration:0.5 animations:^{
       self.frame = CGRectMake(0, SEARCH_VIEW_OPEN_Y, 320, SEARCH_VIEW_OPEN_HEIGHT);
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SEARCH_VIEW_CLOSED_Y, 320, SEARCH_VIEW_CLOSED_HEIGHT);
    }];
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
