//
//  DailyTrackerViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 29/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "DailyTrackerViewController.h"
#import "AddFoodViewController.h"
#import "FoodTrackerItem.h"
#import "User.h"
#import "CoreDataStack.h"

@interface DailyTrackerViewController ()

@property UIButton *addFoodButton;
@property UILabel *dateLabel;
@property float dateInterval;
@property NSMutableArray *foodTrackerItems;
@property NSDictionary *dataSource;
@property NSDate *selectedDate;
@property int caloriesConsumed;
@property UILabel *caloriesConsumedLabel;
@property User *user;
@property CoreDataStack *coreDataStack;

@end

@implementation DailyTrackerViewController
@synthesize addFoodButton, rightArrowImageView, dateLabel, dateInterval, foodTrackerItems, dataSource, selectedDate, caloriesConsumed, caloriesConsumedLabel, myScrollView, user, coreDataStack;

- (void)viewDidLoad
{
    [super viewDidLoad];

    coreDataStack = [CoreDataStack defaultStack];
    [self fetchUser];
    
    selectedDate = [NSDate date];
    
    rightArrowImageView.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
    dateInterval = 0;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"FEAST TRACKER";
    
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
    
    addFoodButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 497, 320, 71)];
    [addFoodButton setImage:[UIImage imageNamed:@"Add_Food_Button@2x.png"] forState:UIControlStateNormal];
    [addFoodButton addTarget:self action:@selector(addFoodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:calorieLabel];
    [self.view addSubview:caloriesConsumedLabel];
    [self.view addSubview:addFoodButton];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    dateInterval = 0;

    dataSource = [self dataForMasterArray];
    NSLog(@"dataSource = %@", dataSource);
    
    [self addDateLabelSubView:selectedDate];
    [self updateFeastTracker];
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
    
    [self calculateCaloriesConsumedLabel];
}

- (void) calculateCaloriesConsumedLabel {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectedDate];
    [components setHour:0];
    
    NSString *selectedMidnightDate = [[calendar dateFromComponents:components] description];
    
    caloriesConsumed = 0;
    if ([dataSource objectForKey:selectedMidnightDate] != nil) {
        for (FoodTrackerItem *foodTrackerItem in [dataSource objectForKey:selectedMidnightDate]) {
            caloriesConsumed += ([foodTrackerItem.numberOfServings intValue] * [foodTrackerItem.caloriesPerServing intValue]);
        }
    }
    
    [caloriesConsumedLabel removeFromSuperview];
    
    caloriesConsumedLabel.text = [NSString stringWithFormat:@"%d", caloriesConsumed];
    [caloriesConsumedLabel sizeToFit];
    caloriesConsumedLabel.frame = CGRectMake(160 - (caloriesConsumedLabel.frame.size.width/2), 100, caloriesConsumedLabel.frame.size.width, caloriesConsumedLabel.frame.size.height);
    
    [self.view addSubview:caloriesConsumedLabel];
}

- (NSDictionary *) dataForMasterArray {
    
    [self populateArrayWithFoodTrackerItems];

    NSDictionary *myDataSource = [[NSDictionary alloc] init];
    myDataSource = [self dataForMealArray];

    return myDataSource;
}

- (NSMutableDictionary *) dataForMealArray {
    
    NSMutableDictionary *myDataSource = [[NSMutableDictionary alloc] init];
    
    if ([foodTrackerItems count] > 0) {
        for (int i = 0; i < [foodTrackerItems count] - 1; i++) {
            FoodTrackerItem *foodTrackerItem = foodTrackerItems[i];
            NSDate *date = user.dateCreated;
            if (foodTrackerItem.date != nil) {
                date = foodTrackerItem.date;
            }
            
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

-(void)updateFeastTracker {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectedDate];
    [components setHour:0];
    
    NSString *selectedMidnightDate = [[calendar dateFromComponents:components] description];
    NSDictionary *mealDictionary = dataSource;
    
    for (UIView *view in myScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    int heightOfScrollView = 0;
    if ([mealDictionary objectForKey:selectedMidnightDate] != nil) {
        for (FoodTrackerItem *foodTrackerItem in [mealDictionary objectForKey:selectedMidnightDate]) {
            heightOfScrollView += 50;
            [myScrollView setContentSize:CGSizeMake(320, heightOfScrollView)];
            
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
            NSLog(@"Name = %@", foodTrackerItem.name);
            
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
            
            [myScrollView addSubview:containerView];
        }
    } else {
        for (UIView *view in myScrollView.subviews) {
            [view removeFromSuperview];
        }
        [myScrollView setContentSize:CGSizeMake(320, heightOfScrollView)];
    }
}

-(void) addFoodButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"AddFoodSegue" sender:self];
}

- (IBAction)dateButtonPrevious:(id)sender {
    dateInterval = dateInterval - (24*60*60);
    [self addDateLabelSubView:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
    [self updateFeastTracker];
}

- (IBAction)dateButtonNext:(id)sender {
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate dateWithTimeIntervalSinceNow:(dateInterval + (24*60*60))]];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    if (([today day] + 1) == [otherDay day] &&
        [today month] == [otherDay month] &&
        [today year] == [otherDay year] &&
        [today era] == [otherDay era]) {
    } else {
        dateInterval = dateInterval + (24*60*60);
        [self addDateLabelSubView:[NSDate dateWithTimeIntervalSinceNow:dateInterval]];
        [self updateFeastTracker];
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) fetchUser {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"(objectId == %@)", [[PFUser currentUser] objectId]];
    [fetchRequest setPredicate:userNamePredicate];
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:coreDataStack.managedObjectContext];
    [fetchRequest setEntity:userEntityDescription];
    NSError *error;
    NSArray *fetchRequestArray = [coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    user = [fetchRequestArray firstObject];
}

@end
