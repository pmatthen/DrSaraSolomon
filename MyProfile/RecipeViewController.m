//
//  RecipeViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 24/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeTableViewCell.h"

@interface RecipeViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *categoryArray;
    NSArray *sectionArray;
}
@end

@implementation RecipeViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = [NSArray new];
    categoryArray = @[@"Breakfast", @"Lunch", @"Dinner", @"Dessert", @"Snacks"];
    sectionArray = [NSArray new];
    sectionArray = @[@"SORT BY MEAL", @"SORT BY NAME"];
}

-(RecipeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = (RecipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MealCell"];
    
    cell.mealTypeLabel.text = categoryArray[indexPath.row];
    
    cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.size.height/2;
    cell.iconImageView.layer.masksToBounds = YES;
    cell.iconImageView.layer.borderWidth = 0;
    
    cell.mealCountLabel.text = @"(???)";
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return sectionArray[section];
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addYourOwnButtonTouched:(id)sender {
}

@end
