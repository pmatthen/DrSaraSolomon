//
//  RecipeSearchViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 14/08/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "RecipeSearchViewController.h"
#import "RecipeSearchTableViewCell.h"
#import "RecipeSampleViewController.h"
#import <FatSecretKit/FSClient.h>
#import <FatSecretKit/FSRecipe.h>

@interface RecipeSearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *resultsArray;
@property (nonatomic, strong) FSRecipe *recipeToSend;

@end

@implementation RecipeSearchViewController
@synthesize myTableView, resultsArray, myTextField, recipeToSend;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    resultsArray = [NSArray new];
    
    [myTextField setBackgroundColor:[UIColor clearColor]];
    myTextField.font = [UIFont fontWithName:@"Oswald" size:22];
    myTextField.textColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"RECIPES";
    
    [self.view addSubview:titleLabel];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeSearchTableViewCell *cell = (RecipeSearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RecipeSearchCell"];

    FSRecipe *tempRecipe = resultsArray[indexPath.row];
    
    cell.myTableViewCellTextLabel.textColor = [UIColor whiteColor];
    cell.myTableViewCellTextLabel.font = [UIFont fontWithName:@"Oswald-Light" size:15];
    cell.myTableViewCellTextLabel.text = [tempRecipe.name lowercaseString];
    
    cell.myTableViewCellImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultsArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    recipeToSend = resultsArray[indexPath.row];
    [self performSegueWithIdentifier:@"RecipeSampleSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RecipeSampleViewController *recipeSampleViewController = (RecipeSampleViewController *) segue.destinationViewController;
    
    recipeSampleViewController.myRecipe = recipeToSend;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    [self searchButtonPressed:self];
    
    return YES;
}

- (IBAction)searchButtonPressed:(id)sender {
    
    if ([myTextField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Nothing Entered" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    } else {
        [[FSClient sharedClient] searchRecipes:myTextField.text recipeType:@"" pageNumber:0 maxResults:20 completion:^(NSArray *recipes, NSString *recipeType, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber) {
            resultsArray = recipes;
            [myTableView reloadData];
        }];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
