//
//  RecipeTableViewCell.h
//  MyProfile
//
//  Created by Vanaja Matthen on 24/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *mealTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealCountLabel;

@end
