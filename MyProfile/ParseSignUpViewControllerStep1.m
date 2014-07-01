//
//  ParseSignUpViewControllerStep1.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep1.h"
#import "ParseSignUpViewControllerStep2.h"

@interface ParseSignUpViewControllerStep1 ()

@end

@implementation ParseSignUpViewControllerStep1
@synthesize nameTextField, emailTextField, usernameTextField, passwordTextField, confirmPasswordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *stepsCountLabelA = [[UILabel alloc] initWithFrame:CGRectMake(60, 56, 140, 35)];
    stepsCountLabelA.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelA.textColor = [UIColor whiteColor];
    stepsCountLabelA.text = @"Just 4 more steps to a ";
    [stepsCountLabelA sizeToFit];
    
    UILabel *stepsCountLabelB = [[UILabel alloc] initWithFrame:CGRectMake(193, 50, 40, 35)];
    stepsCountLabelB.font = [UIFont fontWithName:@"Norican-Regular" size:25];
    stepsCountLabelB.textColor = [UIColor whiteColor];
    stepsCountLabelB.text = @"sexier";
    [stepsCountLabelB sizeToFit];
    
    UILabel *stepsCountLabelC = [[UILabel alloc] initWithFrame:CGRectMake(243, 56, 30, 35)];
    stepsCountLabelC.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelC.textColor = [UIColor whiteColor];
    stepsCountLabelC.text = @" you.";
    [stepsCountLabelC sizeToFit];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 149, 60, 40)];
    stepLabel.font = [UIFont fontWithName:@"Norican-Regular" size:31];
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.text = @"Step 1";
    [stepLabel sizeToFit];
    
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(128, 163, 60, 40)];
    instructionsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    instructionsLabel.textColor = [UIColor whiteColor];
    instructionsLabel.text = @"CREATE AN ACCOUNT";
    [instructionsLabel sizeToFit];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 217, 60, 30)];
    nameLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"name";
    [nameLabel sizeToFit];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 267, 60, 30)];
    emailLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    emailLabel.textColor = [UIColor whiteColor];
    emailLabel.text = @"email";
    [emailLabel sizeToFit];
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 314, 60, 30)];
    usernameLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    usernameLabel.textColor = [UIColor whiteColor];
    usernameLabel.text = @"username";
    [usernameLabel sizeToFit];
    
    UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 364, 60, 30)];
    passwordLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.text = @"password";
    [passwordLabel sizeToFit];
    
    UILabel *confirmPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 412, 60, 30)];
    confirmPasswordLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    confirmPasswordLabel.textColor = [UIColor whiteColor];
    confirmPasswordLabel.text = @"confirm password";
    [confirmPasswordLabel sizeToFit];

    [self.view addSubview:stepsCountLabelA];
    [self.view addSubview:stepsCountLabelB];
    [self.view addSubview:stepsCountLabelC];
    [self.view addSubview:stepLabel];
    [self.view addSubview:instructionsLabel];
    [self.view addSubview:nameLabel];
    [self.view addSubview:emailLabel];
    [self.view addSubview:usernameLabel];
    [self.view addSubview:passwordLabel];
    [self.view addSubview:confirmPasswordLabel];
    
    [nameTextField setBackgroundColor:[UIColor clearColor]];
    nameTextField.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    nameTextField.textColor = [UIColor whiteColor];
    
    [emailTextField setBackgroundColor:[UIColor clearColor]];
    emailTextField.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    emailTextField.textColor = [UIColor whiteColor];
    
    [usernameTextField setBackgroundColor:[UIColor clearColor]];
    usernameTextField.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    usernameTextField.textColor = [UIColor whiteColor];
    
    [passwordTextField setBackgroundColor:[UIColor clearColor]];
    passwordTextField.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    passwordTextField.textColor = [UIColor whiteColor];

    [confirmPasswordTextField setBackgroundColor:[UIColor clearColor]];
    confirmPasswordTextField.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    confirmPasswordTextField.textColor = [UIColor whiteColor];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (IBAction)continueButtonTouched:(id)sender {
    [self performSegueWithIdentifier:@"NextStepSegue" sender:self];
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ParseSignUpViewControllerStep2 *nextStepController = (ParseSignUpViewControllerStep2 *) segue.destinationViewController;
    
    nextStepController.name = nameTextField.text;
    nextStepController.email = emailTextField.text;
    nextStepController.username = usernameTextField.text;
    nextStepController.password = passwordTextField.text;
}

@end
