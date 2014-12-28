//
//  SwipeView.h
//  test
//
//  Created by Matthew Daiter on 9/20/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChooseView.h>

@interface SwipeView : MDCSwipeToChooseView

@property (nonatomic, strong) IBOutlet UILabel* title;

@property (nonatomic, strong) IBOutlet UILabel* quantity;

@property (nonatomic, strong) IBOutlet UILabel* units;

@property (nonatomic, strong) IBOutlet UILabel* price;

@property (nonatomic, strong) IBOutlet UIImageView* image_view;

-(id)initWithOptions:(MDCSwipeToChooseViewOptions *)options title:(NSString*)title quantity:(NSString*)quantity units:(NSString*)units price:(NSString*)price image:(UIImage*)image;


@end
