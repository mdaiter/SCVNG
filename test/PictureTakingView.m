//
//  PictureTakingView.m
//  test
//
//  Created by Matthew Daiter on 9/1/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "PictureTakingView.h"

@implementation PictureTakingView

-(IBAction)takePhoto:(id)sender{
    [self presentCamera];
}

-(void)presentCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else{
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        picker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
        picker.showsCameraControls = YES;
        picker.navigationBarHidden = YES;
        
        [[[self window] rootViewController] presentViewController:picker animated:YES
                         completion:nil];
    }
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
