//
//  ParseSignUpViewControllerStep7.h
//  MyProfile
//
//  Created by Poulose Matthen on 30/07/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseSignUpViewControllerStep7 : UIViewController

- (IBAction)backButtonTouched:(id)sender;

@property NSString *name;
@property NSString *email;
@property NSString *username;
@property NSString *password;
@property int weight;
@property int inchesHeight;
@property int gender;
@property int neat;

@end
