//
//  MoreViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 12/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"

@interface MoreViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation MoreViewController
@synthesize myTableView, categoryArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = @[@"WORKOUTS", @"SHOP", @"NEWSLETTER", @"ABOUT"];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"MORE";
    
    [self.view addSubview:titleLabel];
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell"];
    
    cell.categoryTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:20];
    cell.categoryTitleLabel.text = categoryArray[indexPath.row];
    cell.categoryTitleLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ShopSegue" sender:self];
    }
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"NewsletterSegue" sender:self];
    }
    if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"AboutSegue" sender:self];
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

- (IBAction)resetDataButtonTouched:(id)sender {
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}
@end
