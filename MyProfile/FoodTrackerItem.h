//
//  FoodTrackerItem.h
//  MyProfile
//
//  Created by Poulose Matthen on 26/09/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FoodTrackerItem : NSManagedObject

@property (nonatomic, retain) NSNumber * numberOfServings;
@property (nonatomic, retain) NSString * servingSize;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * caloriesPerServing;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * mealType;

@end
