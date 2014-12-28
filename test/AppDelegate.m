//
//  AppDelegate.m
//  test
//
//  Created by Matthew Daiter on 8/5/14.
//  Copyright (c) 2014 Matthew Daiter. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MainViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Coinbase setClientId:@"2e5635aef714b44be319a2b0534235b984756382115fb5707270e98129bcd933" clientSecret:@"371ea902a1a713b112dd8cf895f628c185ed759229a4ec34ad01fa2ffe04da69"];

    [Parse setApplicationId:@"9TPOsufjWy23CcmY0mUWJDZIHmrMh8t5qjv5VZwT"
                  clientKey:@"a8juHMfb4JFX1KVb9y99SuRISYwrnRFkD8aDYl9k"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];
    
    /*[FBLoginView class];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded){
        NSLog(@"Logged in initially through application. Here's where it'll get interesting.\n");
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession* session, FBSessionState state, NSError* error){
                                          [self sessionStateChanged:session state:state error:error];
        }];
    }
    else{
        NSLog(@"Not logged in\n");
        [self userLoggedOut];
    }*/
    
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
            [self userLoggedOut];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
                [self userLoggedIn];
            } else {
                NSLog(@"User with facebook logged in!");
                [self userLoggedIn];
            }
        }
    }];
    
    // Override point for customization after application launch.
    return YES;
}


-(void) userLoggedIn{
    NSLog(@"Logged in already. Forwarding to main screen.");
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //MainViewController* main_view = (MainViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainView"];
    MainViewController* main_view = [[MainViewController alloc] init];
    self.window.rootViewController = main_view;
    [self.window makeKeyAndVisible];
}

-(void) userLoggedOut{
    NSLog(@"Logged out.");
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController* login_view = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
    self.window.rootViewController = login_view;
    [self.window makeKeyAndVisible];
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            NSLog(@"Something went wrong");
            alertText = [FBErrorUtility userMessageForError:error];
            //[self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                NSLog(@"Session Error");
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                //[self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                NSLog(@"Something went wrong");
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                //[self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[PFFacebookUtils session] close];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    
    // You can add your app-specific url handling code here if needed
    
    return [FBAppCall handleOpenURL:url
                             sourceApplication:sourceApplication
                                   withSession:[PFFacebookUtils session]];

}

@end
