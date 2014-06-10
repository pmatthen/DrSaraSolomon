//
//  RecipeSampleViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 10/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "RecipeSampleViewController.h"
#import "RecipeSampleTableViewCell.h"

@interface RecipeSampleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property int currentSelection;
@property UIImageView *separatorImageView;
@property UIImageView *permanentSeparatorImageView;
@property BOOL isFirstTime;
@property BOOL isFirstClick;

@end

@implementation RecipeSampleViewController
@synthesize categoryArray, currentSelection, myTableView, separatorImageView, permanentSeparatorImageView, isFirstTime, isFirstClick;

- (void)viewDidLoad
{
    [super viewDidLoad];

    categoryArray = @[@"OVERVIEW", @"INGREDIENTS", @"DIRECTIONS"];
    separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    separatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
    permanentSeparatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    permanentSeparatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
    
    isFirstTime = YES;
    isFirstClick = YES;
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
    RecipeSampleTableViewCell *cell = (RecipeSampleTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"RecipeSampleCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitleLabel.text = categoryArray[indexPath.row];

//    switch (indexPath.row) {
//        case 0:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }

    if (isFirstTime) {
        cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
        [cell.contentView addSubview:permanentSeparatorImageView];
        isFirstTime = NO;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isFirstClick) {
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        RecipeSampleTableViewCell *cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:myIndexPath];
        cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
        isFirstClick = NO;
    }
    
    int row = [indexPath row];
    currentSelection = row;
    
    [separatorImageView removeFromSuperview];
    
    RecipeSampleTableViewCell* cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:separatorImageView];
    cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeSampleTableViewCell* cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == currentSelection) {
        return 280;
    }
    else {
        return 44;
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
