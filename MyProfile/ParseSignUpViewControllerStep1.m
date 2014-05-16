//
//  ParseSignUpViewControllerStep1.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep1.h"

@interface ParseSignUpViewControllerStep1 () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation ParseSignUpViewControllerStep1
@synthesize myPickerView, genderArray;

- (void)viewDidLoad
{
    [super viewDidLoad];

    genderArray = [NSArray new];
    genderArray = @[@"Female", @"Male"];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [genderArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return genderArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStepButtonTouched:(id)sender {
}
@end
