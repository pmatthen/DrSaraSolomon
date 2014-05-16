//
//  ParseSignUpViewControllerStep6.h
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseSignUpViewControllerStep6 : UIViewController

- (IBAction)backButtonTouched:(id)sender;
- (IBAction)continueButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
