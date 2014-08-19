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
@property BOOL isFirstTime;
@property BOOL isFirstClick;

@end

@implementation MyProfileViewController
@synthesize categoryArray, currentSelection, myTableView, isFirstTime, isFirstClick;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = @[@"STATUS", @"PROGRESS", @"RECORD WEIGHT"];
    
    isFirstTime = YES;
    isFirstClick = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"MY PROFILE";
    
    UILabel *imageInstructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 131, 39, 30)];
    imageInstructionLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    imageInstructionLabel.textColor = [UIColor whiteColor];
    imageInstructionLabel.text = @"ADD PROFILE PHOTO";
    [imageInstructionLabel sizeToFit];
    
    UIImageView *cameraIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_icon@2x.png"]];
    cameraIconImageView.frame = CGRectMake(138, 94, 39, 30);
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:imageInstructionLabel];
    [self.view addSubview:cameraIconImageView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    cell.myTitleLabel.textColor = [UIColor whiteColor];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];

    switch (indexPath.row) {
        {case 0:
            NSLog(@"");
            UILabel *mainMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 36)];
            [mainMessageLabel setFont:[UIFont boldSystemFontOfSize:30]];
            mainMessageLabel.textAlignment = NSTextAlignmentCenter;
            mainMessageLabel.text = @"You've lost 3lbs";
            
            UILabel *detailMessageLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, 56, 280, 21)];
            [detailMessageLabel setFont:[UIFont boldSystemFontOfSize:17]];
            detailMessageLabel.textAlignment = NSTextAlignmentCenter;
            detailMessageLabel.text = @"Keep going! You're kicking ass.";
            
            [cell.cellContentView addSubview:mainMessageLabel];
            [cell.cellContentView addSubview:detailMessageLabel];
            break;}
        {case 1:
            NSLog(@"");
            UIImageView *graphImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 102)];
            graphImageView.image = [UIImage imageNamed:@"graphImage.png"];
            
            [cell.cellContentView addSubview:graphImageView];
            break;}
        {case 2:
            NSLog(@"");
            UIImageView *pickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 102)];
            pickerImageView.image = [UIImage imageNamed:@"pickerImage.png"];
            
            [cell.cellContentView addSubview:pickerImageView];
            break;}
        {default:
            break;}
    }
    
    if (isFirstTime) {
        cell.myImageView.image = [UIImage imageNamed:@"upArrow@2x.png"];
        isFirstTime = NO;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isFirstClick) {
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[tableView cellForRowAtIndexPath:myIndexPath];
        cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];
        isFirstClick = NO;
    }
    
    int row = (int)[indexPath row];
    currentSelection = row;
    
    
    MyProfileTableViewCell* cell = (MyProfileTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow@2x.png"];

    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileTableViewCell* cell = (MyProfileTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == currentSelection) {
        return 269;
    }
    else {
        return 55;
    }
}

-(IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)populateCell:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        {case 0:
            NSLog(@"0");
            UILabel *mainMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 36)];
            [mainMessageLabel setFont:[UIFont boldSystemFontOfSize:30]];
            mainMessageLabel.text = @"You've lost 3lbs";
            MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[myTableView cellForRowAtIndexPath:indexPath];
            [cell.cellContentView addSubview:mainMessageLabel];
            break;}
        {case 1:
            NSLog(@"1");
            break;}
        {case 2:
            NSLog(@"2");
            break;}
        {default:
            break;}
    }
}

@end