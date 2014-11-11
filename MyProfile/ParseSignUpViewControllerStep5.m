//
//  ParseSignUpViewControllerStep5.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep5.h"
#import "ParseSignUpViewControllerStep6.h"
#import "ParseSignUpViewControllerStep1.h"
#import "ILTranslucentView.h"

@interface ParseSignUpViewControllerStep5 () <UIPickerViewDelegate, UIPickerViewDataSource> {
    ILTranslucentView *translucentView;
    UIButton *closePopUpViewButton;
    UIColor *myFontColor;
}

@end

@implementation ParseSignUpViewControllerStep5
@synthesize myPickerView, neatArray;

- (void)viewDidLoad
{
    myFontColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    
    [super viewDidLoad];
    
    NSLog(@"name = %@, email = %@, username = %@, password = %@, weight = %i, inchesHeight = %i, gender = %i", self.name, self.email, self.username, self.password, self.weight, self.inchesHeight, self.gender);

    neatArray = [NSArray new];
    neatArray = @[@"beginner", @"advanced", @"hardcore"];
    
    UILabel *stepsCountLabelA = [[UILabel alloc] initWithFrame:CGRectMake(89, 56, 140, 35)];
    stepsCountLabelA.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelA.textColor = myFontColor;
    stepsCountLabelA.text = @"Last Step to a ";
    [stepsCountLabelA sizeToFit];
    
    UILabel *stepsCountLabelB = [[UILabel alloc] initWithFrame:CGRectMake(174, 50, 40, 35)];
    stepsCountLabelB.font = [UIFont fontWithName:@"Norican-Regular" size:25];
    stepsCountLabelB.textColor = myFontColor;
    stepsCountLabelB.text = @"sexier";
    [stepsCountLabelB sizeToFit];
    
    UILabel *stepsCountLabelC = [[UILabel alloc] initWithFrame:CGRectMake(224, 56, 30, 35)];
    stepsCountLabelC.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelC.textColor = myFontColor;
    stepsCountLabelC.text = @" you.";
    [stepsCountLabelC sizeToFit];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 149, 60, 40)];
    stepLabel.font = [UIFont fontWithName:@"Norican-Regular" size:31];
    stepLabel.textColor = myFontColor;
    stepLabel.text = @"Step 5";
    [stepLabel sizeToFit];
    
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 163, 60, 40)];
    instructionsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    instructionsLabel.textColor = myFontColor;
    instructionsLabel.text = @"ENTER FITNESSLEVEL";
    [instructionsLabel sizeToFit];
    
    [self.view addSubview:stepsCountLabelA];
    [self.view addSubview:stepsCountLabelB];
    [self.view addSubview:stepsCountLabelC];
    [self.view addSubview:stepLabel];
    [self.view addSubview:instructionsLabel];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [neatArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return neatArray[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Oswald" size:57];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = neatArray[row];
    
    return label;
}

- (IBAction)startOverButtonTouched:(id)sender {
    NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
}

- (IBAction)continueButtonTouched:(id)sender {
}

- (IBAction)popUpButtonTouched:(id)sender {
    translucentView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    translucentView.translucentAlpha = 1;
    translucentView.translucentStyle = UIBarStyleBlack;
    translucentView.translucentTintColor = [UIColor clearColor];
    translucentView.backgroundColor = [UIColor clearColor];
    
    closePopUpViewButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 18, 39, 38)];
    [closePopUpViewButton setImage:[UIImage imageNamed:@"x_icon@2x.png"] forState:UIControlStateNormal];
    [closePopUpViewButton addTarget:self action:@selector(closePopUpViewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *popUpTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 128, 150, 80)];
    popUpTitleLabel.font = [UIFont fontWithName:@"Oswald" size:26];
    popUpTitleLabel.textColor = myFontColor;
    popUpTitleLabel.text = @"FITNESS LEVELS";
    [popUpTitleLabel sizeToFit];
    
    UILabel *beginnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 201, 80, 80)];
    beginnerLabel.font = [UIFont fontWithName:@"Norican-Regular" size:20];
    beginnerLabel.textColor = myFontColor;
    beginnerLabel.text = @"Beginner";
    [beginnerLabel sizeToFit];
    
    UILabel *beginnerDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 227, 80, 80)];
    beginnerDescriptionLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    beginnerDescriptionLabel.textColor = myFontColor;
    beginnerDescriptionLabel.text = @"Exercises 0-2 times a week";
    [beginnerDescriptionLabel sizeToFit];
    
    UIImageView *beginnerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beginner_icon@2x.png"]];
    beginnerImageView.frame = CGRectMake(62, 199, 52, 52);
    
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(67, 270, 194 , 2)];
    separatorView1.backgroundColor = myFontColor;
    
    UILabel *advancedLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 291, 80, 80)];
    advancedLabel.font = [UIFont fontWithName:@"Norican-Regular" size:20];
    advancedLabel.textColor = myFontColor;
    advancedLabel.text = @"Advanced";
    [advancedLabel sizeToFit];
    
    UILabel *advancedDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 317, 80, 80)];
    advancedDescriptionLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    advancedDescriptionLabel.textColor = myFontColor;
    advancedDescriptionLabel.text = @"Exercises 3-5 times a week";
    [advancedDescriptionLabel sizeToFit];
    
    UIImageView *advancedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"advanced_icon@2x.png"]];
    advancedImageView.frame = CGRectMake(62, 289, 55, 49);
    
    UIView *separatorView2 = [[UIView alloc] initWithFrame:CGRectMake(67, 360, 194 , 2)];
    separatorView2.backgroundColor = myFontColor;
    
    UILabel *hardcoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 379, 80, 80)];
    hardcoreLabel.font = [UIFont fontWithName:@"Norican-Regular" size:20];
    hardcoreLabel.textColor = myFontColor;
    hardcoreLabel.text = @"Hardcore";
    [hardcoreLabel sizeToFit];
    
    UILabel *hardcoreDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 405, 80, 80)];
    hardcoreDescriptionLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    hardcoreDescriptionLabel.textColor = myFontColor;
    hardcoreDescriptionLabel.text = @"Exercises 7+ times a week";
    [hardcoreDescriptionLabel sizeToFit];
    
    UIImageView *hardcoreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hardcore_icon@2x.png"]];
    hardcoreImageView.frame = CGRectMake(62, 377, 50, 52);
    
    [self.view addSubview:translucentView];
    [translucentView addSubview:closePopUpViewButton];
    [translucentView addSubview:popUpTitleLabel];
    [translucentView addSubview:beginnerLabel];
    [translucentView addSubview:beginnerDescriptionLabel];
    [translucentView addSubview:beginnerImageView];
    [translucentView addSubview:separatorView1];
    [translucentView addSubview:advancedLabel];
    [translucentView addSubview:advancedDescriptionLabel];
    [translucentView addSubview:advancedImageView];
    [translucentView addSubview:separatorView2];
    [translucentView addSubview:hardcoreLabel];
    [translucentView addSubview:hardcoreDescriptionLabel];
    [translucentView addSubview:hardcoreImageView];
}

-(void) closePopUpViewButtonPressed:(UIButton *)sender {
    [translucentView removeFromSuperview];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ParseSignUpViewControllerStep6 *nextStepController = (ParseSignUpViewControllerStep6 *) segue.destinationViewController;
    
    nextStepController.name = self.name;
    nextStepController.email = self.email;
    nextStepController.username = self.username;
    nextStepController.password = self.password;
    nextStepController.weight = self.weight;
    nextStepController.inchesHeight = self.inchesHeight;
    nextStepController.gender = self.gender;
    nextStepController.neat = (int)[myPickerView selectedRowInComponent:0];
}

@end
