//
//  ParseSignUpViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 15/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep3.h"

@interface ParseSignUpViewControllerStep3 () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation ParseSignUpViewControllerStep3
@synthesize myPickerView, weightArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    weightArray = [NSMutableArray new];
    for (int i = 0; i < 500; i++) {
        [weightArray addObject:[NSNumber numberWithInt:i]];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [weightArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@ lbs", [[weightArray objectAtIndex:row] description]];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UILabel *tView = (UILabel *)view;
//    switch (pickerView.tag) {
//        case 0:
//            if (!tView) {
//                tView = [[UILabel alloc] init];
//            }
//            break;
//            
//        default:
//            break;
//    }
//}

- (IBAction)nextStepButtonTouched:(id)sender {

}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
