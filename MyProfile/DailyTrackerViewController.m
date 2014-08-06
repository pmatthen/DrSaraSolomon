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
@property UILabel *dateLabel;
@property float dateInterval;

@end

@implementation DailyTrackerViewController
@synthesize categoryArray, myTableView, separatorImageView, addFoodButton, addFoodButtonImage, addExerciseButton, addExerciseButtonImage, isACellSelected, currentSelection, rightArrowImageView, dateLabel, dateInterval;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rightArrowImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    [self addDateLabelSubView:[NSDate date]];
    dateInterval = 0;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"DAILY TRACKER";
    
    [self.view addSubview:titleLabel];
    
    categoryArray = @[@"BREAKFAST", @"LUNCH", @"DINNER", @"SNACKS", @"EXERCISE"];
    separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    separatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
    
    addFoodButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addFoodButton addTarget:self action:@selector(addFoodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addFoodButton setTitle:@"Add Food" forState:UIControlStateNormal];
    addFoodButton.frame = CGRectMake(40, 296, 240, 40);
    
    addFoodButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 296, 240, 40)];
    addFoodButtonImage.image = [UIImage imageNamed:@"roundedrectangle.png"];
    
    addExerciseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addExerciseButton addTarget:self action:@selector(addExerciseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addExerciseButton setTitle:@"Add Exercise" forState:UIControlStateNormal];
    addExerciseButton.frame = CGRectMake(40, 296, 240, 40);
    
    addExerciseButtonImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 296, 240, 40)];
    addExerciseButtonImage.image = [UIImage imageNamed:@"roundedrectangle.png"];
    
    isACellSelected = NO;
    currentSelection = -1;
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

-(void)addDateLabelSubView:(NSDate *)date {
    [dateLabel removeFromSuperview];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    NSString *dayDate = [[formatter stringFromDate:date] uppercaseString];
    [formatter setDateFormat:@"MMMM"];
    NSString *monthDate = [[formatter stringFromDate:date] uppercaseString];
    [formatter setDateFormat:@"dd, yyyy"];
    NSString *restOfDate = [[formatter stringFromDate:date] uppercaseString];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 67, 200, 50)];
    dateLabel.font = [UIFont fontWithName:@"Oswald" size:15];
    dateLabel.textColor = [UIColor whiteColor];
    
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    if ([today day] == [otherDay day] &&
        [today month] == [otherDay month] &&
        [today year] == [otherDay year] &&
        [today era] == [otherDay era]) {
        dateLabel.text = [NSString stringWithFormat:@"TODAY  |  %@, %@ %@", dayDate, monthDate, restOfDate];
    } else {
        dateLabel.text = [NSString stringWithFormat:@"%@, %@ %@", dayDate, monthDate, restOfDate];
    }
    
    [dateLabel sizeToFit];
    
    float xPosDate = (((276 - 45) - dateLabel.frame.size.width)/ 2) + 45;
    
    dateLabel.frame = CGRectMake(xPosDate, dateLabel.frame.origin.y, dateLabel.frame.size.width, dateLabel.frame.size.height);
    
    [self.view addSubview:dateLabel];
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
        return 356;
    }
    else {
        return 71.2;
    }
}

-(void) addFoodButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"AddFoodSegue" sender:self];
}

-(void) addExerciseButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"AddExerciseSegue" sender:self];
}

- (IBAction)dateButtonPrevious:(id)sender {
    dateInterval = dateInterval - (24*60*60);
    [self addDateLabelSubView:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
}

- (IBAction)dateButtonNext:(id)sender {
    dateInterval = dateInterval + (24*60*60);
    [self addDateLabelSubView:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
