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
@synthesize myPickerView, heightArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    heightArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [heightArray addObject:[NSNumber numberWithInt:i]];
    }
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

- (IBAction)nextStepbuttonTouched:(id)sender {
}

@end
