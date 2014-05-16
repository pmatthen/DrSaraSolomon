//
//  ParseSignUpViewControllerStep4.m
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep4.h"

@interface ParseSignUpViewControllerStep4 () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation ParseSignUpViewControllerStep4
@synthesize myPickerView, idealWeightArray;

- (void)viewDidLoad
{
    [super viewDidLoad];

    idealWeightArray = [NSMutableArray new];
    for (int i = 0; i < 500; i++) {
        [idealWeightArray addObject:[NSNumber numberWithInt:i]];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [idealWeightArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@ lbs", [[idealWeightArray objectAtIndex:row] description]];
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
