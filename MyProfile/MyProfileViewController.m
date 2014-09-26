//
//  MyProfileViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 06/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyProfileTableViewCell.h"
#import "CoreDataStack.h"
#import "User.h"
#import "RecordedWeight.h"

@interface MyProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property int currentSelection;
@property BOOL isFirstTime;
@property BOOL isFirstClick;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MyProfileViewController
@synthesize categoryArray, currentSelection, myTableView, isFirstTime, isFirstClick, myPickerView, weightArray, fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categoryArray = @[@"STATUS", @"PROGRESS", @"RECORD WEIGHT"];
    
    weightArray = [NSMutableArray new];
    for (int i = 0; i < 500; i++) {
        [weightArray addObject:[NSNumber numberWithInt:i]];
    }
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(40, 0, 320, 215)];
    myPickerView.showsSelectionIndicator = NO;
    myPickerView.hidden = NO;
    myPickerView.delegate = self;
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    User *user = [[coreDataStack.managedObjectContext executeFetchRequest:[self userWeightFetchRequest] error:nil] objectAtIndex:0];
    
    [myPickerView selectRow:[user.initialWeight intValue] inComponent:0 animated:NO];
    
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

- (NSFetchRequest *)userWeightFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", [[PFUser currentUser] objectId]];
    [fetchRequest setPredicate:predicate];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"objectId" ascending:NO]];
    
    return fetchRequest;
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
            UIButton *updateButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, 100, 55)];
            [updateButton setImage:[UIImage imageNamed:@"update_button.png"] forState:UIControlStateNormal];
            [updateButton addTarget:self
                       action:@selector(updateButtonTouched:)
             forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *lbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 90, 50, 50)];
            lbsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:30];
            lbsLabel.textColor = [UIColor whiteColor];
            lbsLabel.text = @"lbs";
            [lbsLabel sizeToFit];
            
            [cell.cellContentView addSubview:myPickerView];
            [cell.cellContentView addSubview:updateButton];
            [cell.cellContentView addSubview:lbsLabel];
            
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [weightArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", [[weightArray objectAtIndex:row] description]];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Oswald" size:70];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@", weightArray[row]];
    
    return label;
}

-(IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)updateButtonTouched:(id)sender {
    // Check whether the users weight has already been recorded that day, and if so it deletes that record. Then it records a new weight and date recorded.
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSArray *recordedWeights = [coreDataStack.managedObjectContext executeFetchRequest:[self recordedWeightFetchRequest] error:nil];
    
    for (RecordedWeight *recordedWeight in recordedWeights) {
        NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:recordedWeight.date];
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
        if([today day] == [otherDay day] &&
           [today month] == [otherDay month] &&
           [today year] == [otherDay year] &&
           [today era] == [otherDay era]) {
            [coreDataStack.managedObjectContext deleteObject:recordedWeight];
            NSLog(@"Weight deleted");
        }
    }
    
    RecordedWeight *weight = [NSEntityDescription insertNewObjectForEntityForName:@"RecordedWeight" inManagedObjectContext:coreDataStack.managedObjectContext];
    weight.weight = [NSNumber numberWithInt:(int)[myPickerView selectedRowInComponent:0]];
    weight.date = [NSDate date];
    
    [coreDataStack saveContext];
    NSLog(@"Weight Added");
}

- (NSFetchRequest *)recordedWeightFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RecordedWeight"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

@end