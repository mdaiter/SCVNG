//
//  AchievementView.h
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AchievementView : UIView

@property (nonatomic, strong) IBOutlet UILabel* title;

@property (nonatomic, strong) IBOutlet UILabel* description;

@property (nonatomic, strong) IBOutlet UIImageView* image_view;

-(id)initWithTitle:(NSString*)title andDescription:(NSString*)description andImage:(UIImage*)image;

@end
