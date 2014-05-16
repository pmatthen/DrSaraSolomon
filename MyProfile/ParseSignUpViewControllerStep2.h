//
//  ParseSignUpViewControllerStep2.h
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseSignUpViewControllerStep2 : UIViewController

- (IBAction)backButtonTouched:(id)sender;
- (IBAction)nextStepbuttonTouched:(id)sender;


@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;
@property NSMutableArray *heightArray;

@end
