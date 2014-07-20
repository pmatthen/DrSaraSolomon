//
//  ParseSignUpViewControllerStep1.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep1.h"
#import "ParseSignUpViewControllerStep2.h"

#define kOFFSET_FOR_KEYBOARD 216.0


@interface ParseSignUpViewControllerStep1 ()

@end

@implementation ParseSignUpViewControllerStep1
@synthesize nameTextField, emailTextField, usernameTextField, passwordTextField, confirmPasswordTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow {
    
    NSLog(@"Keyboard Will Show.");
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    NSLog(@"Keyboard Will Hide.");
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

-(void)dismissKeyboard {
    for (UITextField *myTextField in self.view.subviews) {
        [myTextField resignFirstResponder];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
