//
//  ProtocolTimingViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 24/11/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ProtocolTimingViewController.h"

@interface ProtocolTimingViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSMutableArray *hourArray;
@property NSMutableArray *minuteArray;

@end

@implementation ProtocolTimingViewController
@synthesize myEatingPickerView, myFastingPickerView, hourArray, minuteArray, protocolSelection;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hourArray = [NSMutableArray new];
    for (int i = 0; i < 24; i++) {
        [hourArray addObject:[NSNumber numberWithInt:i]];
    }
    
    minuteArray = [NSMutableArray new];
    for (int i = 0; i < 60; i++) {
        [minuteArray addObject:[NSNumber numberWithInt:i]];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    int eatingWindow = 0;
    switch (protocolSelection) {
        case 1:
            eatingWindow = 4;
            break;
        case 2:
            eatingWindow = 8;
            break;
        case 3:
            eatingWindow = 12;
            break;
        default:
            break;
    }
    
    [myFastingPickerView selectRow:(([myEatingPickerView selectedRowInComponent:0] + eatingWindow) % 24) inComponent:0 animated:YES];
    [myFastingPickerView selectRow:[myEatingPickerView selectedRowInComponent:1] inComponent:1 animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [hourArray count];
    }
    
    return [minuteArray count];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component){
        case 0:
            return 60.0f;
        case 1:
            return 60.0f;
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [hourArray description];
    }
    
    return [minuteArray description];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Oswald" size:26];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0) {
        if ([hourArray[row] integerValue] < 10) {
            label.text = [NSString stringWithFormat:@"0%@", hourArray[row]];
        } else {
            label.text = [NSString stringWithFormat:@"%@", hourArray[row]];
        }
    } else {
        if ([minuteArray[row] integerValue] < 10) {
            label.text = [NSString stringWithFormat:@"0%@", minuteArray[row]];
        } else {
            label.text = [NSString stringWithFormat:@"%@", minuteArray[row]];
        }
    }
    
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    int fastingWindow = 0;
    int eatingWindow = 0;
    switch (protocolSelection) {
        case 1:
            fastingWindow = 20;
            eatingWindow = 4;
            break;
        case 2:
            fastingWindow = 16;
            eatingWindow = 8;
            break;
        case 3:
            fastingWindow = 36;
            eatingWindow = 12;
            break;
        default:
            break;
    }
    
    if (pickerView == myEatingPickerView) {
        [myFastingPickerView selectRow:(([myEatingPickerView selectedRowInComponent:0] + eatingWindow) % 24) inComponent:0 animated:YES];
        [myFastingPickerView selectRow:[myEatingPickerView selectedRowInComponent:1] inComponent:1 animated:YES];
    } else {
        [myEatingPickerView selectRow:(([myFastingPickerView selectedRowInComponent:0] + fastingWindow) % 24) inComponent:0 animated:YES];
        [myEatingPickerView selectRow:[myFastingPickerView selectedRowInComponent:1] inComponent:1 animated:YES];
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)updateSettingsButtonTouched:(id)sender {
}

@end
