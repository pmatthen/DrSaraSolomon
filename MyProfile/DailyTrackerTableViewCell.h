//
//  DailyTrackerTableViewCell.h
//  MyProfile
//
//  Created by Poulose Matthen on 29/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyTrackerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UIImageView *myCategoryImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property BOOL isSelected;

@end
