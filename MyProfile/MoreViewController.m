//
//  MoreViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 12/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        PFLogInViewController *login = [PFLogInViewController new];
        login.delegate = self;
        login.signUpController.delegate = self;
        [self presentViewController:login animated:animated completion:nil];
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)logoutButtonTouched:(id)sender {
    [PFUser logOut];
    UINavigationController *myInitialNavigationController = [UINavigationController new];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    myInitialNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"InitialNavigationController"];
    
    [self presentViewController:myInitialNavigationController animated:NO completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
@end
