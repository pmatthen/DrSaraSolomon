//
//  DailyTrackerViewController.h
//  MyProfile
//
//  Created by Poulose Matthen on 29/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyTrackerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)backButtonTouched:(id)sender;

@end
