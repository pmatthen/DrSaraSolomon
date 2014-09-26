//
//  User.h
//  MyProfile
//
//  Created by Poulose Matthen on 26/09/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * activityFactor;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * initialWeight;
@property (nonatomic, retain) NSNumber * maintenenceCalorieLevel;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSData * userPhoto;

@end
