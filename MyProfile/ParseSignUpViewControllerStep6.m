//
//  ParseSignUpViewControllerStep6.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep6.h"
#import "Parse/Parse.h"

@interface ParseSignUpViewControllerStep6 () <UITextFieldDelegate>

@end

@implementation ParseSignUpViewControllerStep6
@synthesize userNameTextField, emailTextField, passwordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)continueButtonTouched:(id)sender {
    PFUser *user = [PFUser user];
    user.username = userNameTextField.text;
    user.password = passwordTextField.text;
    user.email = emailTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"User signed up");
            } else {
                NSString *errorString = [error userInfo][@"error"];
            }
    }];
}
@end
