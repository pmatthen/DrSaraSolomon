//
//  ParseSignUpViewControllerStep5.h
//  MyProfile
//
//  Created by Vanaja Matthen on 16/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseSignUpViewControllerStep5 : UIViewController

- (IBAction)backButtonTouched:(id)sender;
- (IBAction)continueButtonTouched:(id)sender;
- (IBAction)popUpButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *myPickerView;
@property NSArray *neatArray;
@property NSString *name;
@property NSString *email;
@property NSString *username;
@property NSString *password;
@property int weight;
@property int inchesHeight;
@property int gender;

@end
