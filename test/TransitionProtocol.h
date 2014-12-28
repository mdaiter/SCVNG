//
//  TransitionProtocol.h
//  test
//
//  Created by Matthew Daiter on 9/19/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TransitionProtocol;
@protocol TransitionProtocol <NSObject>

@optional
-(void)transitionToViewController:(UIViewController*) viewController withSender: (id) sender;

@end


@interface TransitionProtocol : NSObject

@end
