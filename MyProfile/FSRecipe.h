//
//  FSFood.h
//  Tracker
//
//  Created by Poulose Matthen on 08/06/14.
//

#import <Foundation/Foundation.h>

@interface FSRecipe : NSObject

@property (nonatomic, strong, readonly) NSString *recipeDescription;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, strong, readonly) NSData *recipeImage;
@property (nonatomic, assign, readonly) NSInteger identifier;

@property (nonatomic, strong, readonly) NSArray *servings;
// Include Preparation times, Cooking times, Directions, and Ingredients


+ (id) recipeWithJSON:(NSDictionary *)json;

@end
