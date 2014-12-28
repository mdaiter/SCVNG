//
//  PictureTakingView.h
//  test
//
//  Created by Matthew Daiter on 9/1/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureTakingView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(void)presentCamera;

-(IBAction)takePhoto:(id)sender;

@end
