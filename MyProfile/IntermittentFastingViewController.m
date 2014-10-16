//
//  IntermittentFastingViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 11/10/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "IntermittentFastingViewController.h"
#import "IntermittentFastingTableViewCell.h"
#import "CoreDataStack.h"
#import "User.h"

@interface IntermittentFastingViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property BOOL isFirstTime;
@property BOOL isFirstClick;
@property int currentSelection;
@property NSMutableArray *protocolTitleLabels;
@property NSMutableArray *protocolInformationViews;
@property int protocolTitleSelection;
@property BOOL fNotifications;
@property BOOL eNotifications;
@property CoreDataStack *coreDataStack;
@property User *user;

@end

@implementation IntermittentFastingViewController
@synthesize protocolArray, myPickerView, myTableView, categoryArray, isFirstTime, isFirstClick, currentSelection, protocolTitleLabels, protocolInformationViews, protocolTitleSelection, fNotifications, eNotifications, user, coreDataStack;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    coreDataStack = [CoreDataStack defaultStack];
    [self fetchUser];
    fNotifications = [user.fNotifications boolValue];
    eNotifications = [user.eNotifications boolValue];
    
    protocolArray = @[@"20/4 Feeding", @"16/8 (recommended)", @"Alternate Day Diet"];
    [myPickerView selectRow:1 inComponent:0 animated:NO];
    
    categoryArray = @[@"INFORMATION", @"TIMER", @"SETTINGS"];
    protocolTitleLabels = [NSMutableArray new];
    protocolInformationViews = [NSMutableArray new];
    [self makeInformationViews];
    
    protocolTitleSelection = 0;
    
    isFirstTime = YES;
    isFirstClick = YES;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 150, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"INTERMITTENT FASTING";
    
    UILabel *protocolPickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(86, 65, 100, 100)];
    protocolPickerLabel.font = [UIFont fontWithName:@"Norican-Regular" size:23];
    protocolPickerLabel.textColor = [UIColor whiteColor];
    protocolPickerLabel.text = @"Current Protocol :";
    [protocolPickerLabel sizeToFit];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:protocolPickerLabel];
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [protocolArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return protocolArray[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 26;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Oswald" size:24];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = protocolArray[row];
    
    return label;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntermittentFastingTableViewCell *cell = (IntermittentFastingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"IntermittentFastingCell"];
    
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
            UIImageView *protocolDividerImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 69, 240, 20)];
            [protocolDividerImage1 setImage:[UIImage imageNamed:@"protocoldividers_thin.png"]];
            
            UIImageView *protocolDividerImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 110, 240, 20)];
            [protocolDividerImage2 setImage:[UIImage imageNamed:@"protocoldividers_thin.png"]];
            
            UIButton *leftArrowTouched = [[UIButton alloc] initWithFrame:CGRectMake(40, 90, 22, 20)];
            leftArrowTouched.tag = 1;
            [leftArrowTouched setImage:[UIImage imageNamed:@"triangleArrow.png"] forState:UIControlStateNormal];
            [leftArrowTouched addTarget:self action:@selector(protocolArrowTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *rightArrowTouched = [[UIButton alloc] initWithFrame:CGRectMake(258, 90, 22, 20)];
            rightArrowTouched.tag = 2;
            [rightArrowTouched setImage:[UIImage imageNamed:@"triangleArrow.png"] forState:UIControlStateNormal];
            rightArrowTouched.layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
            [rightArrowTouched addTarget:self action:@selector(protocolArrowTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:protocolDividerImage1];
            [cell.contentView addSubview:protocolDividerImage2];
            
            [cell.contentView addSubview:leftArrowTouched];
            [cell.contentView addSubview:rightArrowTouched];
            
            for (UIView *protocolTitleView in cell.contentView.subviews) {
                if (protocolTitleView.tag == 3) {
                    [protocolTitleView removeFromSuperview];
                }
            }
            
            [cell.contentView addSubview:protocolTitleLabels[protocolTitleSelection]];
            [cell.contentView addSubview:protocolInformationViews[protocolTitleSelection]];
            break;}
        {case 1:
            NSLog(@"");
            break;}
        {case 2:
            NSLog(@"");
            UILabel *fNotificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 72, 200, 70)];
            fNotificationLabel.font = [UIFont fontWithName:@"Oswald-Light" size:15];
            fNotificationLabel.textColor = [UIColor whiteColor];
            fNotificationLabel.text = @"ENABLE FASTING NOTIFICATIONS";
            [fNotificationLabel sizeToFit];
            
            UILabel *eNotificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 110, 200, 70)];
            eNotificationLabel.font = [UIFont fontWithName:@"Oswald-Light" size:15];
            eNotificationLabel.textColor = [UIColor whiteColor];
            eNotificationLabel.text = @"ENABLE EATING NOTIFICATIONS";
            [eNotificationLabel sizeToFit];
            
            [cell.contentView addSubview:fNotificationLabel];
            [cell.contentView addSubview:eNotificationLabel];
            
            for (UIButton *notificationButton in cell.contentView.subviews) {
                if (notificationButton.tag == 4 || notificationButton.tag == 5) {
                    [notificationButton removeFromSuperview];
                }
            }
            
            UIButton *fNotificationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 69, 26, 27)];
            fNotificationButton.tag = 4;
            
            if (fNotifications == YES) {
                [fNotificationButton setImage:[UIImage imageNamed:@"enable_box_selected.png"] forState:UIControlStateNormal];
            } else {
                [fNotificationButton setImage:[UIImage imageNamed:@"enable_box.png"] forState:UIControlStateNormal];
            }
            
            [fNotificationButton addTarget:self action:@selector(notificationSelectionButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *eNotificationButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 106, 26, 27)];
            eNotificationButton.tag = 5;
            
            if (eNotifications == YES) {
                [eNotificationButton setImage:[UIImage imageNamed:@"enable_box_selected.png"] forState:UIControlStateNormal];
            } else {
                [eNotificationButton setImage:[UIImage imageNamed:@"enable_box.png"] forState:UIControlStateNormal];
            }
            
            [eNotificationButton addTarget:self action:@selector(notificationSelectionButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:fNotificationButton];
            [cell.contentView addSubview:eNotificationButton];
            
            UIButton *updateButton = [[UIButton alloc] initWithFrame:CGRectMake(160 - (225/2), 140, 225, 66)];
            [updateButton setImage:[UIImage imageNamed:@"update_button.png"] forState:UIControlStateNormal];
            [updateButton addTarget:self action:@selector(updateButtonTouched) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:updateButton];
            break;}
        default:
            break;
    }
    
    if (isFirstTime) {
        cell.myImageView.image = [UIImage imageNamed:@"upArrow@2x.png"];
        isFirstTime = NO;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];
    }
    
    return cell;
}

-(void) makeInformationViews {
    UILabel *twentyByFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 100)];
    twentyByFourLabel.font = [UIFont fontWithName:@"Norican-Regular" size:18];
    twentyByFourLabel.textColor = [UIColor whiteColor];
    twentyByFourLabel.text = @"20/4";
    [twentyByFourLabel sizeToFit];
    
    UILabel *feedingLabel = [[UILabel alloc] initWithFrame:CGRectMake(twentyByFourLabel.frame.size.width + 5, 15, 100, 100)];
    feedingLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    feedingLabel.textColor = [UIColor whiteColor];
    feedingLabel.text = @"Feeding";
    [feedingLabel sizeToFit];
    
    UIView *twentyByFourView = [[UIView alloc] initWithFrame:CGRectMake((160 - ((twentyByFourLabel.frame.size.width + feedingLabel.frame.size.width + 5)/2)), 72, (twentyByFourLabel.frame.size.width + feedingLabel.frame.size.width + 5), 150)];
    [twentyByFourView addSubview:twentyByFourLabel];
    [twentyByFourView addSubview:feedingLabel];
    twentyByFourView.tag = 3;
    
    [protocolTitleLabels addObject:twentyByFourView];
    
    UILabel *sixteenByEightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 100)];
    sixteenByEightLabel.font = [UIFont fontWithName:@"Norican-Regular" size:18];
    sixteenByEightLabel.textColor = [UIColor whiteColor];
    sixteenByEightLabel.text = @"16/8";
    [sixteenByEightLabel sizeToFit];
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(sixteenByEightLabel.frame.size.width + 5, 17, 100, 100)];
    protocolLabel.font = [UIFont fontWithName:@"Oswald-Light" size:15];
    protocolLabel.textColor = [UIColor whiteColor];
    protocolLabel.text = @"PROTOCOL";
    [protocolLabel sizeToFit];
    
    UIView *sixteenByEightView = [[UIView alloc] initWithFrame:CGRectMake(160 - ((sixteenByEightLabel.frame.size.width + protocolLabel.frame.size.width + 5)/2), 72, (sixteenByEightLabel.frame.size.width + protocolLabel.frame.size.width + 5), 150)];
    [sixteenByEightView addSubview:sixteenByEightLabel];
    [sixteenByEightView addSubview:protocolLabel];
    sixteenByEightView.tag = 3;
    
    [protocolTitleLabels addObject:sixteenByEightView];
    
    UILabel *alternateDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, 100, 100)];
    alternateDayLabel.font = [UIFont fontWithName:@"Oswald-Light" size:15];
    alternateDayLabel.textColor = [UIColor whiteColor];
    alternateDayLabel.text = @"ALTERNATE DAY DIET";
    [alternateDayLabel sizeToFit];
    
    UIView *alternateDayView = [[UIView alloc] initWithFrame:CGRectMake(160 - (alternateDayLabel.frame.size.width/2), 72, alternateDayLabel.frame.size.width, 150)];
    [alternateDayView addSubview:alternateDayLabel];
    alternateDayView.tag = 3;
    
    [protocolTitleLabels addObject:alternateDayView];
    
    UILabel *twentyByFourInstructionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43, 0, 237, 50)];
    twentyByFourInstructionLabel1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    twentyByFourInstructionLabel1.textColor = [UIColor whiteColor];
    twentyByFourInstructionLabel1.text = @"Fast for 20 consecutive hours";
    
    UILabel *bulletPoint1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 20, 20)];
    bulletPoint1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    bulletPoint1.textColor = [UIColor whiteColor];
    bulletPoint1.text = @".";
    
    UILabel *twentyByFourInstructionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 22, 237, 50)];
    twentyByFourInstructionLabel2.numberOfLines = 0;
    NSString *twentyByFourInstructionLabel2String = @"Preferably train fasted in the morning, using Branch Chain Amino Acids (BCAAs)";
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    [style2 setLineHeightMultiple:0.75];
    NSDictionary *attributes2 = @{NSParagraphStyleAttributeName: style2};
    twentyByFourInstructionLabel2.attributedText = [[NSAttributedString alloc] initWithString:twentyByFourInstructionLabel2String attributes:attributes2];
    twentyByFourInstructionLabel2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    twentyByFourInstructionLabel2.textColor = [UIColor whiteColor];
    
    UILabel *bulletPoint2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 26, 20, 20)];
    bulletPoint2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    bulletPoint2.textColor = [UIColor whiteColor];
    bulletPoint2.text = @".";
    
    UILabel *twentyByFourInstructionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(43, 47, 237, 50)];
    twentyByFourInstructionLabel3.numberOfLines = 0;
    NSString *twentyByFourInstructionLabel3String = @"Eat for 4 consecutive hours (e.g., skip breakfast and lunch and eat from 5 p.m. until 9 p.m.)";
    NSMutableParagraphStyle *style3 = [[NSMutableParagraphStyle alloc] init];
    [style3 setLineHeightMultiple:0.75];
    NSDictionary *attributes3 = @{NSParagraphStyleAttributeName: style3};
    twentyByFourInstructionLabel3.attributedText = [[NSAttributedString alloc] initWithString:twentyByFourInstructionLabel3String attributes:attributes3];
    twentyByFourInstructionLabel3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    twentyByFourInstructionLabel3.textColor = [UIColor whiteColor];

    UILabel *bulletPoint3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 51, 20, 20)];
    bulletPoint3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    bulletPoint3.textColor = [UIColor whiteColor];
    bulletPoint3.text = @".";
    
    UILabel *twentyByFourInstructionLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(43, 65, 237, 50)];
    twentyByFourInstructionLabel4.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    twentyByFourInstructionLabel4.textColor = [UIColor whiteColor];
    twentyByFourInstructionLabel4.text = @"Repeat this daily";
    
    UILabel *bulletPoint4 = [[UILabel alloc] initWithFrame:CGRectMake(35, 76, 20, 20)];
    bulletPoint4.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    bulletPoint4.textColor = [UIColor whiteColor];
    bulletPoint4.text = @".";
    
    UIView *twentyByFourInformationView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 320, 106)];
    twentyByFourInformationView.tag = 3;
    [twentyByFourInformationView addSubview:twentyByFourInstructionLabel1];
    [twentyByFourInformationView addSubview:bulletPoint1];
    [twentyByFourInformationView addSubview:twentyByFourInstructionLabel2];
    [twentyByFourInformationView addSubview:bulletPoint2];
    [twentyByFourInformationView addSubview:twentyByFourInstructionLabel3];
    [twentyByFourInformationView addSubview:bulletPoint3];
    [twentyByFourInformationView addSubview:twentyByFourInstructionLabel4];
    [twentyByFourInformationView addSubview:bulletPoint4];
    
    [protocolInformationViews addObject:twentyByFourInformationView];
    
    UILabel *sixteenByEightInstructionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43, 0, 237, 50)];
    sixteenByEightInstructionLabel1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightInstructionLabel1.textColor = [UIColor whiteColor];
    sixteenByEightInstructionLabel1.text = @"Fast for 16 consecutive hours";
    
    UILabel *sixteenByEightbulletPoint1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 20, 20)];
    sixteenByEightbulletPoint1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightbulletPoint1.textColor = [UIColor whiteColor];
    sixteenByEightbulletPoint1.text = @".";
    
    UILabel *sixteenByEightInstructionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 22, 237, 50)];
    sixteenByEightInstructionLabel2.numberOfLines = 0;
    NSString *sixteenByEightInstructionLabel2String = @"Preferably train fasted in the morning, using Branch Chain Amino Acids (BCAAs)";
    NSMutableParagraphStyle *sixteenByEightStyle2 = [[NSMutableParagraphStyle alloc] init];
    [sixteenByEightStyle2 setLineHeightMultiple:0.75];
    NSDictionary *sixteenByEightAttributes2 = @{NSParagraphStyleAttributeName: sixteenByEightStyle2};
    sixteenByEightInstructionLabel2.attributedText = [[NSAttributedString alloc] initWithString:sixteenByEightInstructionLabel2String attributes:sixteenByEightAttributes2];
    sixteenByEightInstructionLabel2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightInstructionLabel2.textColor = [UIColor whiteColor];
    
    UILabel *sixteenByEightBulletPoint2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 26, 20, 20)];
    sixteenByEightBulletPoint2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightBulletPoint2.textColor = [UIColor whiteColor];
    sixteenByEightBulletPoint2.text = @".";
    
    UILabel *sixteenByEightInstructionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(43, 47, 237, 50)];
    sixteenByEightInstructionLabel3.numberOfLines = 0;
    NSString *sixteenByEightInstructionLabel3String = @"Eat for 8 consecutive hours (e.g., skip breakfast and eat from noon until 8 p.m.)";
    NSMutableParagraphStyle *sixteenByEightStyle3 = [[NSMutableParagraphStyle alloc] init];
    [sixteenByEightStyle3 setLineHeightMultiple:0.75];
    NSDictionary *sixteenByEightAttributes3 = @{NSParagraphStyleAttributeName: sixteenByEightStyle3};
    sixteenByEightInstructionLabel3.attributedText = [[NSAttributedString alloc] initWithString:sixteenByEightInstructionLabel3String attributes:sixteenByEightAttributes3];
    sixteenByEightInstructionLabel3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightInstructionLabel3.textColor = [UIColor whiteColor];
    
    UILabel *sixteenByEightBulletPoint3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 51, 20, 20)];
    sixteenByEightBulletPoint3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightBulletPoint3.textColor = [UIColor whiteColor];
    sixteenByEightBulletPoint3.text = @".";
    
    UILabel *sixteenByEightInstructionLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(43, 65, 237, 50)];
    sixteenByEightInstructionLabel4.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightInstructionLabel4.textColor = [UIColor whiteColor];
    sixteenByEightInstructionLabel4.text = @"Repeat this daily";
    
    UILabel *sixteenByEightBulletPoint4 = [[UILabel alloc] initWithFrame:CGRectMake(35, 76, 20, 20)];
    sixteenByEightBulletPoint4.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    sixteenByEightBulletPoint4.textColor = [UIColor whiteColor];
    sixteenByEightBulletPoint4.text = @".";
    
    UIView *sixteenByEightInformationView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 320, 106)];
    sixteenByEightInformationView.tag = 3;
    [sixteenByEightInformationView addSubview:sixteenByEightInstructionLabel1];
    [sixteenByEightInformationView addSubview:sixteenByEightbulletPoint1];
    [sixteenByEightInformationView addSubview:sixteenByEightInstructionLabel2];
    [sixteenByEightInformationView addSubview:sixteenByEightBulletPoint2];
    [sixteenByEightInformationView addSubview:sixteenByEightInstructionLabel3];
    [sixteenByEightInformationView addSubview:sixteenByEightBulletPoint3];
    [sixteenByEightInformationView addSubview:sixteenByEightInstructionLabel4];
    [sixteenByEightInformationView addSubview:sixteenByEightBulletPoint4];
    
    [protocolInformationViews addObject:sixteenByEightInformationView];
    
    UILabel *alternateDayInstructionLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(43, 0, 237, 50)];
    alternateDayInstructionLabel1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDayInstructionLabel1.textColor = [UIColor whiteColor];
    alternateDayInstructionLabel1.text = @"Fast for 36 consecutive hours";
    
    UILabel *alternateDaybulletPoint1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 20, 20)];
    alternateDaybulletPoint1.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDaybulletPoint1.textColor = [UIColor whiteColor];
    alternateDaybulletPoint1.text = @".";
    
    UILabel *alternateDayInstructionLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(43, 22, 237, 50)];
    alternateDayInstructionLabel2.numberOfLines = 0;
    NSString *alternateDayInstructionLabel2String = @"Preferably train fasted in the morning, using Branch Chain Amino Acids (BCAAs)";
    NSMutableParagraphStyle *alternateDayStyle2 = [[NSMutableParagraphStyle alloc] init];
    [alternateDayStyle2 setLineHeightMultiple:0.75];
    NSDictionary *alternateDayAttributes2 = @{NSParagraphStyleAttributeName: alternateDayStyle2};
    alternateDayInstructionLabel2.attributedText = [[NSAttributedString alloc] initWithString:alternateDayInstructionLabel2String attributes:alternateDayAttributes2];
    alternateDayInstructionLabel2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDayInstructionLabel2.textColor = [UIColor whiteColor];
    
    UILabel *alternateDayBulletPoint2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 26, 20, 20)];
    alternateDayBulletPoint2.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDayBulletPoint2.textColor = [UIColor whiteColor];
    alternateDayBulletPoint2.text = @".";
    
    UILabel *alternateDayInstructionLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(43, 40, 237, 50)];
    alternateDayInstructionLabel3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDayInstructionLabel3.textColor = [UIColor whiteColor];
    alternateDayInstructionLabel3.text = @"Eat on alternating days ";
    
    UILabel *alternateDaybulletPoint3 = [[UILabel alloc] initWithFrame:CGRectMake(35, 51, 20, 20)];
    alternateDaybulletPoint3.font = [UIFont fontWithName:@"Oswald-Light" size:10];
    alternateDaybulletPoint3.textColor = [UIColor whiteColor];
    alternateDaybulletPoint3.text = @".";
    
    UIView *alternateDayInformationView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 320, 106)];
    alternateDayInformationView.tag = 3;
    [alternateDayInformationView addSubview:alternateDayInstructionLabel1];
    [alternateDayInformationView addSubview:alternateDaybulletPoint1];
    [alternateDayInformationView addSubview:alternateDayInstructionLabel2];
    [alternateDayInformationView addSubview:alternateDayBulletPoint2];
    [alternateDayInformationView addSubview:alternateDayInstructionLabel3];
    [alternateDayInformationView addSubview:alternateDaybulletPoint3];
    
    [protocolInformationViews addObject:alternateDayInformationView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isFirstClick) {
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        IntermittentFastingTableViewCell *cell = (IntermittentFastingTableViewCell *)[tableView cellForRowAtIndexPath:myIndexPath];
        cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];
        isFirstClick = NO;
    }
    
    int row = (int)[indexPath row];
    currentSelection = row;
    
    IntermittentFastingTableViewCell* cell = (IntermittentFastingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow@2x.png"];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    IntermittentFastingTableViewCell* cell = (IntermittentFastingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"downArrow@2x.png"];

    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == currentSelection) {
        return 218;
    }
    else {
        return 55;
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)protocolHelpButtonTouched:(id)sender {
}

-(void) protocolArrowTouched:(UIButton *)sender {
    if (sender.tag == 1 && protocolTitleSelection > 0) {
        protocolTitleSelection -= 1;
        [myTableView reloadData];
    }
    
    if (sender.tag == 2 && protocolTitleSelection < 2) {
        protocolTitleSelection += 1;
        [myTableView reloadData];
    }
}

-(void) notificationSelectionButtonTouched:(UIButton *)sender {
    if (sender.tag == 4) {
        fNotifications = !fNotifications;
    }
    if (sender.tag == 5) {
        eNotifications = !eNotifications;
    }
    
    [myTableView reloadData];
}

-(void) updateButtonTouched {
    NSLog(@"user.fNotifications = %@", user.fNotifications);
    NSLog(@"user.eNotifications = %@", user.eNotifications);
    
    user.fNotifications = [NSNumber numberWithBool:fNotifications];
    user.eNotifications = [NSNumber numberWithBool:eNotifications];
    
    [coreDataStack saveContext];
    [myTableView reloadData];
    
    NSLog(@"user.fNotifications = %@", user.fNotifications);
    NSLog(@"user.eNotifications = %@", user.eNotifications);
}

- (IBAction)startButtonTouched:(id)sender {
}
@end
