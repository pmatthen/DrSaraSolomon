//
//  DailyTrackerViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 29/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "DailyTrackerViewController.h"
#import "DailyTrackerTableViewCell.h"

@interface DailyTrackerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property UIImageView *separatorImageView;
@property UIButton *addFoodButton;
@property UIImageView *addFoodButtonImage;
@property UIButton *addExerciseButton;
@property UIImageView *addExerciseButtonImage;
@property BOOL isACellSelected;
@property int currentSelection;

@end

@implementation DailyTrackerViewController
@synthesize categoryArray, myTableView, separatorImageView, addFoodButton, addFoodButtonImage, addExerciseButton, addExerciseButtonImage, isACellSelected, currentSelection;

- (void)viewDidLoad
{
    [super viewDidLoad];

    categoryArray = @[@"BREAKFAST", @"LUNCH", @"DINNER", @"SNACKS", @"EXERCISE"];
    separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    separatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
    
    addFoodButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addFoodButton addTarget:self action:@selector(addFoodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addFoodButton setTitle:@"Add Food" forState:UIControlStateNormal];
    addFoodButton.frame = CGRectMake(40, 330, 240, 40);
    
    addFoodButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 330, 240, 40)];
    addFoodButtonImage.image = [UIImage imageNamed:@"roundedrectangle.png"];
    
    addExerciseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addExerciseButton addTarget:self action:@selector(addExerciseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addExerciseButton setTitle:@"Add Exercise" forState:UIControlStateNormal];
    addExerciseButton.frame = CGRectMake(40, 330, 240, 40);
    
    addExerciseButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 330, 240, 40)];
    addExerciseButtonImage.image = [UIImage imageNamed:@"roundedrectangle.png"];
    
    isACellSelected = NO;
    currentSelection = -1;
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
    DailyTrackerTableViewCell *cell = (DailyTrackerTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"DailyTrackerCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    cell.isSelected = NO;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTrackerTableViewCell* cell = (DailyTrackerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
    
    if (cell.isSelected) {
        [separatorImageView removeFromSuperview];
        if (indexPath.row == 4) {
            [addExerciseButton removeFromSuperview];
            [addExerciseButtonImage removeFromSuperview];
        } else {
            [addFoodButton removeFromSuperview];
            [addFoodButtonImage removeFromSuperview];
        }
        [cell.contentView addSubview:separatorImageView];
        if (indexPath.row == 4) {
            addExerciseButton.tag = indexPath.row;
            [cell addSubview:addExerciseButton];
            [cell addSubview:addExerciseButtonImage];
        } else {
            addFoodButton.tag = indexPath.row;
            [cell addSubview:addFoodButton];
            [cell addSubview:addFoodButtonImage];
        }
        cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
        cell.myTitleLabel.text = categoryArray[indexPath.row];
        
        isACellSelected = YES;
        currentSelection = (int) indexPath.row;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
        cell.myTitleLabel.text = categoryArray[indexPath.row];
        isACellSelected = NO;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTrackerTableViewCell *cell = (DailyTrackerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isACellSelected && currentSelection == indexPath.row) {
        return 390;
    }
    else {
        return 78;
    }
}

-(void) addFoodButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"AddFoodSegue" sender:self];
}

-(void) addExerciseButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"AddExerciseSegue" sender:self];
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
