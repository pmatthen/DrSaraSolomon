//
//  ParseSignUpViewControllerStep7.m
//  MyProfile
//
//  Created by Poulose Matthen on 30/07/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep7.h"

@interface ParseSignUpViewControllerStep7 ()

@end

@implementation ParseSignUpViewControllerStep7

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"name = %@, email = %@, username = %@, password = %@, weight = %i, inchesHeight = %i, gender = %i, neat = %i", self.name, self.email, self.username, self.password, self.weight, self.inchesHeight, self.gender, self.neat);

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 56, 30, 35)];
    headerLabel.font = [UIFont fontWithName:@"Oswald-Light" size:25];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.text = @"Your results are up!";
    NSLog(@"Width = %f", headerLabel.frame.size.width);
    [headerLabel sizeToFit];
    NSLog(@"Width = %f", headerLabel.frame.size.width);
    
    UILabel *recommendedLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 278, 40, 35)];
    recommendedLabel.font = [UIFont fontWithName:@"Norican-Regular" size:18];
    recommendedLabel.textColor = [UIColor whiteColor];
    recommendedLabel.text = @"Recommended";
    [recommendedLabel sizeToFit];
    
    UILabel *calorieIntakeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 301, 100, 50)];
    calorieIntakeLabel.font = [UIFont fontWithName:@"Oswald" size:13];
    calorieIntakeLabel.textColor = [UIColor whiteColor];
    calorieIntakeLabel.text = @"CALORIE INTAKE:";
    [calorieIntakeLabel sizeToFit];
    
    UILabel *rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 274, 100, 100)];
    rangeLabel.font = [UIFont fontWithName:@"Oswald" size:35];
    rangeLabel.textColor = [UIColor whiteColor];
    rangeLabel.text = [NSString stringWithFormat:@"%.f -%.f", ([self maintenanceLevelCalories:self.weight heightInInches:self.inchesHeight age:31 gender:self.gender neat:self.neat] * .86), ([self maintenanceLevelCalories:self.weight heightInInches:self.inchesHeight age:31 gender:self.gender neat:self.neat] * 1.14)];
    
    [rangeLabel sizeToFit];
    
    [self.view addSubview:headerLabel];
    [self.view addSubview:recommendedLabel];
    [self.view addSubview:calorieIntakeLabel];
    [self.view addSubview:rangeLabel];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(float)maintenanceLevelCalories:(int)weight heightInInches:(int)height age:(int)age gender:(int)gender neat:(int)neat {
    
    //Include neat into calculations with array.
    if (gender == 0) {
        return (655 + (4.35 * weight) + (4.7 * height) - (4.7 * age));
    } else {
        return (66 + (6.23 * weight) + (12.7 * height) - (6.8 * age));
    }
}

@end
