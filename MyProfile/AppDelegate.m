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
#import "FSRecipe.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [Parse setApplicationId:@"sg0S2sXCo3hsLKmdfEZsH3be3BLSCCcLKAkD8gLT" clientKey:@"kXUT03o75PdfdGMe6ZDOVEKPcTtdDmLgx6czaj1l"];
    
    [FSClient sharedClient].oauthConsumerKey = @"2fb6164b75774378867a87cb92c2a0be";
    [FSClient sharedClient].oauthConsumerSecret = @"08812a0266a54999916213b04beff83a";
    
    [[FSClient sharedClient] searchFoods:@"Red Thai Curry Chicken"
                              completion:^(NSArray *foods, NSInteger maxResults, NSInteger totalResults, NSInteger pageNumber) {
                                  // Use data as you will.
                                  
                                  for (int i = 0; i < [foods count]; i++) {
                                      FSFood *tempFood = foods[i];
                                      NSLog(@"food #%d = %@, %@", i, tempFood.name, tempFood.foodDescription);
                                  }
                              }];
    
    [[FSClient sharedClient] searchRecipes:@"Lamb Curry"
                                recipeType:@"Main Dishes"
                                pageNumber:0
                                maxResults:20
                                completion:^(NSArray *recipes, NSInteger maxResults, NSInteger totalResults, NSInteger pagenumber) {
                                    for (int i = 0; i < [recipes count]; i++) {
                                        FSRecipe *tempRecipe = recipes[i];
                                        NSLog(@"recipe #%d = %@", i, tempRecipe.name);
                                    }
                                }];
    
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
