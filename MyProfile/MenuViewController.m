//
//  ViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 05/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewTableViewCell.h"
#import "InitialViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) NSArray *categoryArray;

@end

@implementation MenuViewController
@synthesize myTableView, categoryArray;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = @[@"MY PROFILE", @"DAILY TRACKER", @"RECIPES", @"WORKOUTS", @"MORE"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if (![PFUser currentUser]) {
        UINavigationController *myInitialNavigationController = [UINavigationController new];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        myInitialNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"InitialNavigationController"];

        [self presentViewController:myInitialNavigationController animated:animated completion:nil];
    }
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"sender = %@", sender);
}

#pragma mark - tableview

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewTableViewCell *cell = (MenuViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    cell.categoryTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:26];
    cell.categoryTitleLabel.text = categoryArray[indexPath.row];
    cell.categoryTitleLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(255, 40, 43, 48)];
    arrowImageView.image = [UIImage imageNamed:@"MainMenu - arrow@2x.png"];
    [cell addSubview:arrowImageView];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_rectangle@2x.png"]];

    switch (indexPath.row) {
        case 0:
            cell.myImageView.image = [UIImage imageNamed:@"myprofile_icon@2x.png"];
            break;
        case 1:
            cell.myImageView.image = [UIImage imageNamed:@"dailytracker_icon@2x.png"];
            break;
        case 2:
            cell.myImageView.image = [UIImage imageNamed:@"recipes_icon@2x.png"];
            break;
        case 3:
            cell.myImageView.image = [UIImage imageNamed:@"workouts_icon@2x.png"];
            break;
        case 4:
            cell.myImageView.image = [UIImage imageNamed:@"more_icon@2x.png"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoryArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"MyProfileSegue" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"DailyTrackerSegue" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"RecipeSegue" sender:self];
            break;
        case 3:
            //
            break;
        case 4:
            [self performSegueWithIdentifier:@"MoreSegue" sender:self];
            break;
        default:
            break;
    }
}

@end
