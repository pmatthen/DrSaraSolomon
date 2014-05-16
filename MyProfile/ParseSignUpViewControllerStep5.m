//
//  ParseSignUpViewControllerStep5.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep5.h"

@interface ParseSignUpViewControllerStep5 () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ParseSignUpViewControllerStep5
@synthesize myPickerView, neatArray;

- (void)viewDidLoad
{
    [super viewDidLoad];

    neatArray = [NSArray new];
    neatArray = @[@"Bedridden individual", @"Sedentary Occupation without daily movement", @"Sedentary Occupation with daily movement", @"Occupation with prolonged standing", @"Strenuous occupation"];
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)nextStepButtonTouched:(id)sender {
}
@end
