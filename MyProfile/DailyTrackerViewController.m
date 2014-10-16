//
//  DailyTrackerViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 29/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "DailyTrackerViewController.h"
#import "DailyTrackerTableViewCell.h"
#import "AddFoodViewController.h"
#import "FoodTrackerItem.h"

@interface DailyTrackerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *iconImagePathArray;
@property UIImageView *separatorImageView;
@property UIButton *addFoodButton;
@property BOOL isACellSelected;
@property int currentSelection;
@property UILabel *dateLabel;
@property float dateInterval;
@property NSNumber *addFoodButtonTag;
@property NSMutableArray *foodTrackerItems;
@property NSMutableArray *dataSource;
@property NSDate *selectedDate;
@property int caloriesConsumed;
@property UILabel *caloriesConsumedLabel;

@end

@implementation DailyTrackerViewController
@synthesize categoryArray, iconImagePathArray, myTableView, separatorImageView, addFoodButton, isACellSelected, currentSelection, rightArrowImageView, dateLabel, dateInterval, addFoodButtonTag, foodTrackerItems, dataSource, selectedDate, caloriesConsumed, caloriesConsumedLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedDate = [NSDate date];
    
    rightArrowImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    dateInterval = 0;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"DAILY TRACKER";
    
    [self.view addSubview:titleLabel];
    
    UILabel *calorieLabel = [[UILabel alloc] init];
    calorieLabel.font = [UIFont fontWithName:@"Oswald" size:14];
    calorieLabel.textColor = [UIColor whiteColor];
    calorieLabel.text = @"CALORIES CONSUMED";
    [calorieLabel sizeToFit];
    calorieLabel.frame = CGRectMake(160 - (calorieLabel.frame.size.width/2), 185, calorieLabel.frame.size.width, calorieLabel.frame.size.height);
    
    caloriesConsumedLabel = [[UILabel alloc] init];
    caloriesConsumedLabel.font = [UIFont fontWithName:@"Oswald" size:55];
    caloriesConsumedLabel.textColor = [UIColor whiteColor];
    caloriesConsumedLabel.text = @"0";
    [caloriesConsumedLabel sizeToFit];
    caloriesConsumedLabel.frame = CGRectMake(160 - (caloriesConsumedLabel.frame.size.width/2), 100, caloriesConsumedLabel.frame.size.width, caloriesConsumedLabel.frame.size.height);
    
    [self.view addSubview:calorieLabel];
    [self.view addSubview:caloriesConsumedLabel];
    
    categoryArray = @[@"BREAKFAST", @"LUNCH", @"DINNER", @"SNACKS"];
    iconImagePathArray = @[@"breakfasticon@2x.png", @"lunchicon@2x.png", @"dinnericon@2x.png", @"snackicon@2x.png"];
    separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"separatorLine.png"]];
    separatorImageView.frame = CGRectMake(0, 0, 320, 0.25);
    
    addFoodButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 476, 320, 92)];
    [addFoodButton setImage:[UIImage imageNamed:@"addfoodbutton_activated@2x.png"] forState:UIControlStateNormal];
    [addFoodButton addTarget:self action:@selector(addFoodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    isACellSelected = NO;
    currentSelection = -1;
    dateInterval = 0;
    [addFoodButton removeFromSuperview];

    dataSource = [self dataForMasterArray];
    for (int i = 0; i <[dataSource count]; i++) {
        NSLog(@"dataSource[%i] = %@", i, dataSource[i]);
    }
    
    [self addDateLabelSubView:selectedDate];
    [myTableView reloadData];
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

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    selectedDate = [calendar dateFromComponents:otherDay];
    
    // Close up cells in myTableView upon new date selection.
    currentSelection = -1;
    [myTableView reloadData];
    
    [self calculateCaloriesConsumedLabel];
}

- (void) calculateCaloriesConsumedLabel {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectedDate];
    [components setHour:0];
    
    NSString *selectedMidnightDate = [[calendar dateFromComponents:components] description];
    
    caloriesConsumed = 0;
    for (int i = 0; i < [dataSource count]; i++) {
        NSMutableDictionary *mealDictionary = [dataSource objectAtIndex:i];
        if ([mealDictionary objectForKey:selectedMidnightDate] != nil) {
            for (FoodTrackerItem *foodTrackerItem in [mealDictionary objectForKey:selectedMidnightDate]) {
                caloriesConsumed += ([foodTrackerItem.numberOfServings intValue] * [foodTrackerItem.caloriesPerServing intValue]);
            }
        }
    }
    
    [caloriesConsumedLabel removeFromSuperview];
    
    caloriesConsumedLabel.text = [NSString stringWithFormat:@"%d", caloriesConsumed];
    [caloriesConsumedLabel sizeToFit];
    caloriesConsumedLabel.frame = CGRectMake(160 - (caloriesConsumedLabel.frame.size.width/2), 100, caloriesConsumedLabel.frame.size.width, caloriesConsumedLabel.frame.size.height);
    
    [self.view addSubview:caloriesConsumedLabel];
}

- (NSMutableArray *) dataForMasterArray {
    
    [self populateArrayWithFoodTrackerItems];
    
    NSArray *breakfastArray = [[NSArray alloc] init];
    NSArray *lunchArray = [[NSArray alloc] init];
    NSArray *dinnerArray = [[NSArray alloc] init];
    NSArray *snacksArray = [[NSArray alloc] init];

    NSMutableArray *myDataSource = [[NSMutableArray alloc] init];
    [myDataSource addObject:breakfastArray];
    [myDataSource addObject:lunchArray];
    [myDataSource addObject:dinnerArray];
    [myDataSource addObject:snacksArray];
    
    for (int i = 0; i < [myDataSource count]; i++) {
        myDataSource[i] = [self dataForMealArray:[NSNumber numberWithInt:i]];
    }

    return myDataSource;
}

- (NSMutableDictionary *) dataForMealArray:(NSNumber *)meal {
    
    NSMutableDictionary *myDataSource = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [foodTrackerItems count]; i++) {
        FoodTrackerItem *foodTrackerItem = foodTrackerItems[i];
        if ([foodTrackerItem.mealType isEqualToNumber:meal]) {
            NSDate *date = foodTrackerItem.date;
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
            [components setHour:0];

            NSString *midnightDate = [[calendar dateFromComponents:components] description];
            NSMutableArray *section = [myDataSource objectForKey:midnightDate];
            
            if (!section) {
                section = [[NSMutableArray alloc] init];
                [myDataSource setObject:section forKey:midnightDate];
            }
            
            [section addObject:foodTrackerItem];
        }
    }

    return myDataSource;
}

- (void) populateArrayWithFoodTrackerItems {
    // Loads all foodTrackItem objects into an Array in descending order of date created
    
    [foodTrackerItems removeAllObjects];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    foodTrackerItems = [NSMutableArray arrayWithArray:[coreDataStack.managedObjectContext executeFetchRequest:[self foodTrackerItemFetchRequest] error:nil]];
}

- (NSFetchRequest *) foodTrackerItemFetchRequest {
    // Just a fetchRequest.
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"FoodTrackerItem"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DailyTrackerTableViewCell *cell = (DailyTrackerTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"DailyTrackerCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitleLabel.font = [UIFont fontWithName:@"Oswald" size:16];
    cell.myTitleLabel.textColor = [UIColor whiteColor];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    cell.myCategoryImageView.image = [UIImage imageNamed:iconImagePathArray[indexPath.row]];
    cell.myImageView.image = [UIImage imageNamed:@"arrow@2x.png"];
    cell.myImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    
    cell.isSelected = NO;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectedDate];
    [components setHour:0];
    
    NSString *selectedMidnightDate = [[calendar dateFromComponents:components] description];
    NSMutableDictionary *mealDictionary = [dataSource objectAtIndex:indexPath.row];
    
    for (UIView *view in cell.myScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    int heightOfScrollView = 0;
    if ([mealDictionary objectForKey:selectedMidnightDate] != nil) {
        for (FoodTrackerItem *foodTrackerItem in [mealDictionary objectForKey:selectedMidnightDate]) {
            heightOfScrollView += 50;
            [cell.myScrollView setContentSize:CGSizeMake(320, heightOfScrollView)];
            
            UIImageView *dividerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 11)];
            [dividerImageView setImage:[UIImage imageNamed:@"divider@2x.png"]];
            
            UILabel *numberOfServingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 12, 30, 38)];
            numberOfServingsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
            numberOfServingsLabel.textColor = [UIColor whiteColor];
            numberOfServingsLabel.text = [NSString stringWithFormat:@"%@", foodTrackerItem.numberOfServings];
            
            UILabel *xLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 12, 8, 38)];
            xLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
            xLabel.textColor = [UIColor whiteColor];
            xLabel.text = @"x";
            
            UILabel *foodTrackerItemDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 12, 255, 38)];
            foodTrackerItemDetailLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
            foodTrackerItemDetailLabel.textColor = [UIColor whiteColor];
            foodTrackerItemDetailLabel.text = [NSString stringWithFormat:@"%@ %@",foodTrackerItem.servingSize, foodTrackerItem.name];
            
            UILabel *calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(277, 12, 43, 38)];
            calorieLabel.font = [UIFont fontWithName:@"Oswald" size:18];
            calorieLabel.textColor = [UIColor whiteColor];
            calorieLabel.text = [NSString stringWithFormat:@"%d", ([foodTrackerItem.caloriesPerServing intValue] * [foodTrackerItem.numberOfServings intValue])];
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScrollView - 50, 320, 50)];
            
            [containerView addSubview:dividerImageView];
            [containerView addSubview:numberOfServingsLabel];
            [containerView addSubview:xLabel];
            [containerView addSubview:foodTrackerItemDetailLabel];
            [containerView addSubview:calorieLabel];
            
            [cell.myScrollView addSubview:containerView];
        }
    } else {
        for (UIView *view in cell.myScrollView.subviews) {
            [view removeFromSuperview];
        }
        
        [cell.myScrollView setContentSize:CGSizeMake(320, heightOfScrollView)];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTrackerTableViewCell* cell = (DailyTrackerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
    
    if (cell.isSelected) {
        [separatorImageView removeFromSuperview];
        [addFoodButton removeFromSuperview];
        
        [cell.contentView addSubview:separatorImageView];
        addFoodButton.tag = indexPath.row;
        [self.view addSubview:addFoodButton];
        cell.myImageView.image = [UIImage imageNamed:@"arrow@2x.png"];
        cell.myImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2 + M_PI);
        cell.myTitleLabel.text = categoryArray[indexPath.row];
        
        isACellSelected = YES;
        currentSelection = (int) indexPath.row;
    } else {
        [addFoodButton removeFromSuperview];
        cell.myImageView.image = [UIImage imageNamed:@"arrow@2x.png"];
        cell.myImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
        cell.myTitleLabel.text = categoryArray[indexPath.row];
        isACellSelected = NO;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DailyTrackerTableViewCell *cell = (DailyTrackerTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"arrow@2x.png"];
    cell.myImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI/2);
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isACellSelected && currentSelection == indexPath.row) {
        if (indexPath.row == 3) {
            return 356;
        }
        return (356 - 88);
    }
    else {
        return 88;
    }
}

-(void) addFoodButtonPressed:(UIButton *)sender {
    addFoodButtonTag = [NSNumber numberWithLong:sender.tag];
    [self performSegueWithIdentifier:@"AddFoodSegue" sender:self];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddFoodViewController *nextStepController = (AddFoodViewController *) segue.destinationViewController;
    nextStepController.addFoodButtonTag = addFoodButtonTag;
}

@end
