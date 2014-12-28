//
//  AchievementView.m
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "AchievementView.h"

@implementation AchievementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithTitle:(NSString *)title andDescription:(NSString *)description andImage:(UIImage *)image{
    self = [super init];
    if (self) {
        // Initialization code
        _title.text = title;
        //description.text = description;
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
