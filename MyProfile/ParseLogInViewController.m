//
//  ParseLogInViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 15/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseLogInViewController.h"
#import "MenuViewController.h"

@interface ParseLogInViewController () <UITextFieldDelegate>

@end

@implementation ParseLogInViewController
@synthesize usernameTextField, passwordTextField, myImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)logInButtonTouched:(id)sender {
    [PFUser logInWithUsernameInBackground:usernameTextField.text password:passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (user) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            MenuViewController *myMenuViewController = [MenuViewController new];
            myMenuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewNavigationController"];
            [self presentViewController:myMenuViewController animated:NO completion:nil];
        } else {
            NSLog(@"error = %@", error);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Username or Password has been entered incorrectly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
