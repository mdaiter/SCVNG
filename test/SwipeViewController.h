//
//  SwipeViewController.h
//  test
//
//  Created by Matthew Daiter on 9/3/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>

@interface SwipeViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) IBOutlet MDCSwipeToChooseView *swipe_view;

@end
