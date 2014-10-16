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
#import "SaveImageNSValueTransformer.h"
#import <QuartzCore/QuartzCore.h>
#import "BEMSimpleLineGraphView.h"

@interface MyProfileViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property int currentSelection;
@property BOOL isFirstTime;
@property BOOL isFirstClick;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property UIImageView *cameraIconImageView;
@property UILabel *imageInstructionLabel;
@property(nonatomic, retain) UIImage *coreDataUserImage;
@property CoreDataStack *coreDataStack;
@property User *user;
@property NSArray *recordedWeights;
@property UILabel *gainedOrLostLabel;
@property UILabel *motivationLabel;
@property UILabel *amountLabel;
@property UILabel *lbsLabel;
@property UIView *messageView;
@property BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;
@property UIView *pickerViewView;

@end

@implementation MyProfileViewController
@synthesize categoryArray, currentSelection, myTableView, isFirstTime, isFirstClick, myPickerView, weightArray, fetchedResultsController, myCameraButton, cameraIconImageView, imageInstructionLabel, coreDataUserImage, coreDataStack, user, recordedWeights, gainedOrLostLabel, motivationLabel, amountLabel, lbsLabel, messageView, myGraph, arrayOfValues, arrayOfDates, pickerViewView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    recordedWeights = [NSArray new];
    
    myCameraButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    myCameraButton.imageView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth);
    myCameraButton.imageView.layer.cornerRadius = myCameraButton.frame.size.height/2;
    myCameraButton.imageView.clipsToBounds = YES;
    [myCameraButton.imageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [myCameraButton.imageView.layer setBorderWidth:2.0];
    
    categoryArray = @[@"STATUS", @"PROGRESS", @"RECORD WEIGHT"];
    
    weightArray = [NSMutableArray new];
    for (int i = 0; i < 500; i++) {
        [weightArray addObject:[NSNumber numberWithInt:i]];
    }
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(-15, -39, 320, 215)];
    myPickerView.showsSelectionIndicator = NO;
    myPickerView.hidden = NO;
    myPickerView.delegate = self;
    
    pickerViewView = [[UIView alloc] initWithFrame:CGRectMake(-20, -24, 320, 102)];
    [pickerViewView setBackgroundColor:[UIColor greenColor]];
    pickerViewView.clipsToBounds = YES;
    [pickerViewView addSubview:myPickerView];
    
    coreDataStack = [CoreDataStack defaultStack];

    [self fillRecordedWeightsArray];
    [self fetchUser];
    [myPickerView selectRow:[user.initialWeight intValue] inComponent:0 animated:NO];
    
    arrayOfDates = [[NSMutableArray alloc] initWithArray:@[@"Oct 14", @"Oct 15", @"Oct 16", @"Oct 17", @"Oct 18", @"Oct 19", @"Oct 20", @"Oct 21", @"Oct 22", @"Oct 23", @"Oct 24", @"Oct 25", @"Oct 26", @"Oct 27", @"Oct 28", @"Oct 29", @"Oct 30", @"Oct 31", @"Nov 1", @"Nov 2", @"Nov 3", @"Nov 4", @"Nov 5", @"Nov 6", @"Nov 7", @"Nov 8", @"Nov 9", @"Nov 10"]];
    arrayOfValues = [[NSMutableArray alloc] initWithArray:@[@145, @145, @144, @144, @142, @141, @143, @143, @145, @146, @145, @144, @144, @143, @143, @142, @141, @140, @139, @138, @138, @137, @137, @136, @135, @133, @131, @110]];
    
    myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(40, 102, 240, 120)];
    myGraph.dataSource = self;
    myGraph.delegate = self;
    
    myGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    myGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    myGraph.colorLine = [UIColor whiteColor];
    myGraph.colorXaxisLabel = [UIColor whiteColor];
    myGraph.colorYaxisLabel = [UIColor whiteColor];
    myGraph.widthLine = 2.0;
    myGraph.enableTouchReport = YES;
    myGraph.enablePopUpReport = YES;
    myGraph.enableBezierCurve = NO;
    myGraph.enableYAxisLabel = YES;
    myGraph.autoScaleYAxis = YES;
    myGraph.alwaysDisplayDots = NO;
    myGraph.enableReferenceAxisLines = YES;
    myGraph.enableReferenceAxisFrame = YES;
    myGraph.animationGraphStyle = BEMLineAnimationFade;
    
    isFirstTime = YES;
    isFirstClick = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"MY PROFILE";
    
    imageInstructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(112, 131, 39, 30)];
    imageInstructionLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    imageInstructionLabel.textColor = [UIColor whiteColor];
    imageInstructionLabel.text = @"ADD PROFILE PHOTO";
    [imageInstructionLabel sizeToFit];
    
    cameraIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_icon@2x.png"]];
    cameraIconImageView.frame = CGRectMake(138, 94, 39, 30);

    [myCameraButton setImage:[[UIImage alloc]initWithData:user.userPhoto] forState:UIControlStateNormal];
    [myCameraButton setImage:[[UIImage alloc]initWithData:user.userPhoto] forState:UIControlStateHighlighted];
    
    if ([[UIImage alloc]initWithData:user.userPhoto]) {
        cameraIconImageView.hidden = YES;
        imageInstructionLabel.hidden = YES;
    } else {
        [myCameraButton setImage:[UIImage imageNamed:@"deafult_profilepic.png"] forState:UIControlStateNormal];
    }
    
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

- (void) fetchUser {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"(objectId == %@)", [[PFUser currentUser] objectId]];
    [fetchRequest setPredicate:userNamePredicate];
    NSEntityDescription *userEntityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:coreDataStack.managedObjectContext];
    [fetchRequest setEntity:userEntityDescription];
    NSError *error;
    NSArray *fetchRequestArray = [coreDataStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    user = fetchRequestArray[0];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyProfileTableViewCell *cell = (MyProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    cell.myTitleLabel.textColor = [UIColor whiteColor];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor purpleColor];

    switch (indexPath.row) {
        {case 0:
            NSLog(@"");
            [self fillRecordedWeightsArray];

            RecordedWeight *latestWeight = nil;
            
            if ([recordedWeights count] > 0) {
                latestWeight = recordedWeights[0];
                for (RecordedWeight *recordedWeight in recordedWeights) {
                    if ([latestWeight.date compare:recordedWeight.date] == NSOrderedAscending) {
                        latestWeight = recordedWeight;
                    }
                }
            }
            
            [messageView removeFromSuperview];
            [motivationLabel removeFromSuperview];
            
            gainedOrLostLabel = [[UILabel alloc] init];
            motivationLabel = [[UILabel alloc] init];
            
            int weightDifference = [latestWeight.weight intValue] - [user.initialWeight intValue];

            if (latestWeight == nil) {
                gainedOrLostLabel.text = @"YOU'RE ";
                motivationLabel.text = @"Gotta try hard, gotta get sexy!";
            } else if (weightDifference > 0) {
                gainedOrLostLabel.text = @"YOU'VE GAINED ";
                motivationLabel.text = @"Gotta try harder, gotta get sexy!";
            } else if (weightDifference < 0) {
                gainedOrLostLabel.text = @"YOU'VE LOST ";
                motivationLabel.text = @"Keep going. You're kicking ass!";
            } else if (weightDifference == 0) {
                gainedOrLostLabel.text = @"YOU'VE GAINED ";
                motivationLabel.text = @"Keep on it, the results are coming!";
            }
            
            gainedOrLostLabel.font = [UIFont fontWithName:@"Oswald" size:30];
            gainedOrLostLabel.textColor = [UIColor whiteColor];
            gainedOrLostLabel.frame = CGRectMake(0, 104, 100, 100);
            [gainedOrLostLabel sizeToFit];
            
            motivationLabel.font = [UIFont fontWithName:@"Norican-Regular" size:22];
            motivationLabel.textColor = [UIColor whiteColor];
            motivationLabel.frame = CGRectMake(0, 151, 100, 100);
            [motivationLabel sizeToFit];
            motivationLabel.frame = CGRectMake(160 - motivationLabel.frame.size.width/2, motivationLabel.frame.origin.y, motivationLabel.frame.size.width, motivationLabel.frame.size.height);
            
            amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(gainedOrLostLabel.frame.origin.x + gainedOrLostLabel.frame.size.width, gainedOrLostLabel.frame.origin.y - 3, 50, 50)];
            amountLabel.font = [UIFont fontWithName:@"Norican-Regular" size:38];
            amountLabel.textColor = [UIColor whiteColor];
            amountLabel.text = [NSString stringWithFormat:@"%i", abs(weightDifference)];
            [amountLabel sizeToFit];
            
            lbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(amountLabel.frame.origin.x + amountLabel.frame.size.width, amountLabel.frame.origin.y + 3, 50, 50)];
            lbsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:26];
            lbsLabel.textColor = [UIColor whiteColor];
            lbsLabel.text = @"lbs";
            [amountLabel sizeToFit];
            
            messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gainedOrLostLabel.frame.size.width + amountLabel.frame.size.width + lbsLabel.frame.size.width, 50)];
            [messageView addSubview:gainedOrLostLabel];
            [messageView addSubview:amountLabel];
            [messageView addSubview:lbsLabel];
            [messageView sizeToFit];
            messageView.frame = CGRectMake((160 - messageView.frame.size.width/2) + 15, 0, messageView.frame.size.width, messageView.frame.size.height);
            
            [cell.contentView addSubview:messageView];
            [cell.contentView addSubview:motivationLabel];
            break;}
        {case 1:
            NSLog(@"");
            [cell.contentView addSubview:myGraph];
            break;}
        {case 2:
            NSLog(@"");
            UIButton *updateButton = [[UIButton alloc] init];
            [updateButton setImage:[UIImage imageNamed:@"update_button.png"] forState:UIControlStateNormal];
            [updateButton setBackgroundColor:[UIColor blueColor]];
            [updateButton setFrame:CGRectMake(48, 81, 190, 85)];
            [updateButton addTarget:self
                       action:@selector(updateButtonTouched:)
             forControlEvents:UIControlEventTouchUpInside];
            
            lbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(189, 33, 50, 50)];
            lbsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:25];
            lbsLabel.textColor = [UIColor whiteColor];
            lbsLabel.text = @"lbs";
            [lbsLabel sizeToFit];
            
            [cell.cellContentView addSubview:updateButton];
            [cell.cellContentView addSubview:pickerViewView];
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
    label.font = [UIFont fontWithName:@"Oswald" size:80];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@", weightArray[row]];
    
    return label;
}

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[arrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[arrayOfValues objectAtIndex:index] floatValue];
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 4;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *label = [arrayOfDates objectAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

-(IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cameraButtonTouched:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Profile Picture"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo", @"Select Photo", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet cancelButtonIndex])
    {
        // cancelled, nothing happen
        return;
    }
    
    // obtain a human-readable option string
    NSString *option = [actionSheet buttonTitleAtIndex:buttonIndex];

    if ([option isEqualToString:@"Take Photo"]) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        } else {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
        }
    } else if ([option isEqualToString:@"Select Photo"]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    cameraIconImageView.hidden = YES;
    imageInstructionLabel.hidden = YES;
    myCameraButton.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    [user setValue:imageData forKey:@"userPhoto"];
    [coreDataStack saveContext];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)updateButtonTouched:(id)sender {
    NSLog(@"Touched");
    // Check whether the users weight has already been recorded that day, and if so it deletes that record. Then it records a new weight and date recorded.
    
    [self fillRecordedWeightsArray];
    
    int i = 0;
    for (RecordedWeight *recordedWeight in recordedWeights) {
        i += 1;
        NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:recordedWeight.date];
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
        if([today day] == [otherDay day] &&
           [today month] == [otherDay month] &&
           [today year] == [otherDay year] &&
           [today era] == [otherDay era]) {
            [coreDataStack.managedObjectContext deleteObject:recordedWeight];
        }
    }
    
    RecordedWeight *weight = [NSEntityDescription insertNewObjectForEntityForName:@"RecordedWeight" inManagedObjectContext:coreDataStack.managedObjectContext];
    weight.weight = [NSNumber numberWithInt:(int)[myPickerView selectedRowInComponent:0]];
    weight.date = [NSDate date];
    
    [coreDataStack saveContext];
    [myTableView reloadData];
}

- (void) fillRecordedWeightsArray {
    recordedWeights = [coreDataStack.managedObjectContext executeFetchRequest:[self recordedWeightFetchRequest] error:nil];
}

- (NSFetchRequest *)recordedWeightFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RecordedWeight"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    
    return fetchRequest;
}

@end