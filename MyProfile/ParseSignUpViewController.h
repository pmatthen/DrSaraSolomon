//
//  ParseSignUpViewController.h
//  MyProfile
//
//  Created by Vanaja Matthen on 15/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseSignUpViewController : UIViewController

- (IBAction)backButtonTouched:(id)sender;
- (IBAction)nextStepButtonTouched:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UILabel *stepsLeftLabel;
@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *roundedRectangleImageView;
@property (strong, nonatomic) IBOutlet UIButton *nextStepButton;

@property int page;
@property int pages;
@property NSArray *instructionArray;
@property UIView *completedProgressView;

@end
