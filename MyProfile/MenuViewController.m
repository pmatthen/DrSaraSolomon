//
//  ViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 05/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewTableViewCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

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
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

#pragma mark - tableview

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewTableViewCell *cell = (MenuViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.categoryTitleLabel.text = categoryArray[indexPath.row];

    cell.myImageView.layer.cornerRadius = cell.myImageView.frame.size.height/2;
    cell.myImageView.layer.masksToBounds = YES;
    cell.myImageView.layer.borderWidth = 0;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoryArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.title = [categoryArray[indexPath.row] capitalizedString];
}

@end
