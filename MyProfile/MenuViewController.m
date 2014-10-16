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
#import "CoreDataStack.h"
#import "User.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *iconImagepathArray;

@end

@implementation MenuViewController
@synthesize myTableView, categoryArray, iconImagepathArray;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    categoryArray = @[@"MY PROFILE", @"DAILY TRACKER", @"INTERMITTENT FASTING", @"RECIPES", @"MORE"];
    iconImagepathArray = @[@"myprofile_icon@2x.png", @"dailytracker_icon@2x.png", @"intermittent_eatingtimer_active.png", @"recipes_icon@2x.png", @"more_icon@2x.png"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if (![PFUser currentUser]) {
        UINavigationController *myInitialNavigationController = [UINavigationController new];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        myInitialNavigationController = [mainStoryboard instantiateViewControllerWithIdentifier:@"InitialNavigationController"];

        [self presentViewController:myInitialNavigationController animated:animated completion:nil];
    } else {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[[PFUser currentUser] objectId] forKey:@"loggedOnUserID"];
        [defaults synchronize];
        
        [self initializeCoreDataUser];
    }
}

- (void) initializeCoreDataUser {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"objectId" ascending:YES]];
    
    NSError *error = nil;
    NSUInteger count = [coreDataStack.managedObjectContext countForFetchRequest:request error:&error];

    if (count > 0) {
        NSLog(@"User exists and count = %lu", (unsigned long)count);
    } else {
        NSLog(@"User nil");
        User *currentUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:coreDataStack.managedObjectContext];
        currentUser.objectId = [[PFUser currentUser] objectId];
        currentUser.name = [[PFUser currentUser] objectForKey:@"name"];
        currentUser.activityFactor = [[PFUser currentUser] objectForKey:@"neat"];
        currentUser.email = [[PFUser currentUser] objectForKey:@"email"];
        currentUser.height = [[PFUser currentUser] objectForKey:@"height"];
        currentUser.initialWeight = [[PFUser currentUser] objectForKey:@"weight"];
        currentUser.username = [[PFUser currentUser] objectForKey:@"username"];
        currentUser.gender = [[PFUser currentUser] objectForKey:@"gender"];
        currentUser.protocolTypeSelected = 0;
        currentUser.hourToBeginEating = 0;
        currentUser.minuteToBeginEating = 0;
        currentUser.hourToBeginFasting = 0;
        currentUser.minuteToBeginFasting = 0;
        currentUser.fNotifications = NO;
        currentUser.eNotifications = NO;

        [coreDataStack saveContext];
    }
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [signUpController dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLayoutSubviews {
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"sender = %@", sender);
}

#pragma mark - tableview

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuViewTableViewCell *cell = (MenuViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    cell.categoryTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:20];
    cell.categoryTitleLabel.text = categoryArray[indexPath.row];
    cell.categoryTitleLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(255, 41, 43, 48)];
    arrowImageView.image = [UIImage imageNamed:@"MainMenu - arrow@2x.png"];
    [cell addSubview:arrowImageView];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_rectangle@2x.png"]];
    cell.myImageView.image = [UIImage imageNamed:iconImagepathArray[indexPath.row]];
    
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
            [self performSegueWithIdentifier:@"IntermittentFastingSegue" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"RecipeSearchSegue" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"MoreSegue" sender:self];
            break;
        default:
            break;
    }
}

@end
