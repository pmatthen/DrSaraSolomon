//
//  MyProfileViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 06/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyProfileTableViewCell.h"

@interface MyProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property int currentSelection;
@property UIImageView *separatorImageView;

@end

@implementation MyProfileViewController
@synthesize categoryArray, currentSelection, myTableView, separatorImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = @[@"STATUS", @"PROGRESS", @"RECORD WEIGHT"];
    
    separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    separatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = [indexPath row];
    currentSelection = row;
    
    [separatorImageView removeFromSuperview];
    
    MyProfileTableViewCell* cell = (MyProfileTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:separatorImageView];
    cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];

    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileTableViewCell* cell = (MyProfileTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([indexPath row] == currentSelection) {
        return 208;
    }
    else {
        return 80;
    }
}

@end
