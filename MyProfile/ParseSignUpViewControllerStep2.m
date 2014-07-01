//
//  ParseSignUpViewControllerStep2.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep2.h"

@interface ParseSignUpViewControllerStep2 () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation ParseSignUpViewControllerStep2
@synthesize heightArray, name, email, username, password;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    heightArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [heightArray addObject:[NSNumber numberWithInt:i]];
    }
    
    UILabel *stepsCountLabelA = [[UILabel alloc] initWithFrame:CGRectMake(60, 56, 140, 35)];
    stepsCountLabelA.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelA.textColor = [UIColor whiteColor];
    stepsCountLabelA.text = @"Just 3 more steps to a ";
    [stepsCountLabelA sizeToFit];
    
    UILabel *stepsCountLabelB = [[UILabel alloc] initWithFrame:CGRectMake(193, 50, 40, 35)];
    stepsCountLabelB.font = [UIFont fontWithName:@"Norican-Regular" size:25];
    stepsCountLabelB.textColor = [UIColor whiteColor];
    stepsCountLabelB.text = @"sexier";
    [stepsCountLabelB sizeToFit];
    
    UILabel *stepsCountLabelC = [[UILabel alloc] initWithFrame:CGRectMake(243, 56, 30, 35)];
    stepsCountLabelC.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    stepsCountLabelC.textColor = [UIColor whiteColor];
    stepsCountLabelC.text = @" you.";
    [stepsCountLabelC sizeToFit];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 149, 60, 40)];
    stepLabel.font = [UIFont fontWithName:@"Norican-Regular" size:31];
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.text = @"Step 2";
    [stepLabel sizeToFit];
    
    UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(132, 163, 60, 40)];
    instructionsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    instructionsLabel.textColor = [UIColor whiteColor];
    instructionsLabel.text = @"ENTER CURRENT WEIGHT";
    [instructionsLabel sizeToFit];
    
    [self.view addSubview:stepsCountLabelA];
    [self.view addSubview:stepsCountLabelB];
    [self.view addSubview:stepsCountLabelC];
    [self.view addSubview:stepLabel];
    [self.view addSubview:instructionsLabel];
    
    NSLog(@"%@, %@, %@, %@", name, email, username, password);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [heightArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@ \"", heightArray[row]];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
