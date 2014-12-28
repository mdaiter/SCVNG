//
//  CenterViewDelegate.h
//  test
//
//  Created by Matthew Daiter on 8/8/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CenterViewDelegate;
@protocol CenterViewDelegate <NSObject>

@optional
-(void)left_side: (id) sender;
-(void)right_side: (id) sender;
-(void)transitionToViewController:(NSString*) viewController withSender: (id) sender;

@end

@interface CenterViewDelegate : NSObject

@end
