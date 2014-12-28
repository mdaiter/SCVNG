//
//  MainMenuTableViewController.h
//  test
//
//  Created by Matthew Daiter on 8/7/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewDelegate.h"

@interface MainMenuTableViewController : UITableViewController <CenterViewDelegate>

@property (nonatomic, assign) NSArray* menu_items;

@property (weak, nonatomic) id <CenterViewDelegate> delegate;

@end
