//
//  AppDelegate.m
//  MyProfile
//
//  Created by Vanaja Matthen on 05/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import <FatSecretKit/FSClient.h>
#import "FSFood.h"
#import <FatSecretKit/FSServing.h>
#import <FatSecretKit/FSRecipe.h>
#import <FatSecretKit/FSRecipeServings.h>
#import <FatSecretKit/FSRecipeIngredients.h>
#import <FatSecretKit/FSRecipeDirections.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [Parse setApplicationId:@"sg0S2sXCo3hsLKmdfEZsH3be3BLSCCcLKAkD8gLT" clientKey:@"kXUT03o75PdfdGMe6ZDOVEKPcTtdDmLgx6czaj1l"];
    
    [FSClient sharedClient].oauthConsumerKey = @"2fb6164b75774378867a87cb92c2a0be";
    [FSClient sharedClient].oauthConsumerSecret = @"08812a0266a54999916213b04beff83a";
    
    [[FSClient sharedClient] searchFoods:@"roast chicken"
                              completion:^(NSArray *foods, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber) {
                                  // Use data as you will.
                                  
                                  for (int i = 0; i < [foods count]; i++) {
                                      FSFood *tempFood = foods[i];
                                      NSLog(@"food #%d = %@, %li, %@", i, tempFood.name, (long)tempFood.identifier, tempFood.foodDescription);
                                  }
                              }];
    
    [[FSClient sharedClient] getFood:624623 completion:^(FSFood *food) {
        
        NSLog(@"food = %@, %@", food.name, food.foodDescription);
        for (int i = 0; i < [food.servings count]; i++) {
            FSServing *tempServing = food.servings[i];
            NSLog(@"protein = %@", tempServing.protein);
            NSLog(@"proteinValue = %f", tempServing.proteinValue);
            NSLog(@"serving size = %@", tempServing.servingDescription);
        }
    }];
    
//    [[FSClient sharedClient] searchRecipes:@"Chicken Pot Pie" recipeType:@"" pageNumber:0 maxResults:20 completion:^(NSArray *recipes, NSString *recipeType, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber) {
//        for (int i; i < [recipes count]; i++) {
//            FSRecipe *tempRecipe = recipes[i];
//            NSLog(@"Recipe #%d = %@, %@, %li", i, tempRecipe.name, tempRecipe.imageUrl, (long)tempRecipe.identifier);
//        }
//    }];
//
//    [[FSClient sharedClient] getRecipe:5679955 completion:^(FSRecipe *recipe) {
//        NSLog(@"name = %@", recipe.name);
//        NSLog(@"number of Servings = %li", (long)recipe.numberOfServings);
//        NSLog(@"image url = %@", recipe.recipeImage);
//        NSLog(@"cook time (min) = %li", (long)recipe.cookingTimeMin);
//        NSLog(@"prep time (min) = %li", (long)recipe.preparationTimeMin);
//
//        
//        for (int i = 0; i < [recipe.servings count]; i++) {
//            FSRecipeServings *recipeServings = recipe.servings[i];
//            NSLog(@"serving size = %@", recipeServings.servingSize);
//            NSLog(@"calories = %f", recipeServings.caloriesValue);
//            NSLog(@"carbohydrates = %f", recipeServings.carbohydrateValue);
//            NSLog(@"proteins = %f", recipeServings.proteinValue);
//            NSLog(@"fats = %f", recipeServings.fatValue);
//        }
//        for (int i = 0; i < [recipe.ingredients count]; i++) {
//            FSRecipeIngredients *recipeIngredients = recipe.ingredients[i];
//            NSLog(@"ingredient %i = %@", i, recipeIngredients.ingredientDescription);
//        }
//        for (int i = 0; i < [recipe.directions count]; i++) {
//            FSRecipeDirections *recipeDirections = recipe.directions[i];
//            NSLog(@"direction %i = %@", i, recipeDirections.directionDescription);
//        }
//    }];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
