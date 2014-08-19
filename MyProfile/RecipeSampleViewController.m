//
//  RecipeSampleViewController.m
//  MyProfile
//
//  Created by Poulose Matthen on 10/06/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "RecipeSampleViewController.h"
#import "RecipeSampleTableViewCell.h"
#import <FatSecretKit/FSClient.h>
#import <FatSecretKit/FSRecipeDirections.h>
#import <FatSecretKit/FSRecipeIngredients.h>
#import <FatSecretKit/FSRecipeServings.h>

@interface RecipeSampleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property int currentSelection;
@property BOOL isFirstTime;
@property BOOL isFirstClick;

@end

@implementation RecipeSampleViewController
@synthesize categoryArray, currentSelection, myTableView, isFirstTime, isFirstClick, myRecipe, myImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    categoryArray = @[@"OVERVIEW", @"INGREDIENTS", @"DIRECTIONS"];
    
    isFirstTime = YES;
    isFirstClick = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 9, 100, 40)];
    titleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"RECIPES";
    
    [self.view addSubview:titleLabel];
    
    myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self downloadImageWithURL:[NSURL URLWithString:myRecipe.imageUrl] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            myImageView.image = image;
        }
    }];
    
    [[FSClient sharedClient] getRecipe:myRecipe.identifier completion:^(FSRecipe *recipe) {
        
        NSLog(@"name = %@", recipe.name);
        NSLog(@"number of Servings = %li", (long)recipe.numberOfServings);
        NSLog(@"image url = %@", recipe.recipeImage);
        NSLog(@"cook time (min) = %li", (long)recipe.cookingTimeMin);
        NSLog(@"prep time (min) = %li", (long)recipe.preparationTimeMin);
        
        for (int i = 0; i < [recipe.servings count]; i++) {
            FSRecipeServings *recipeServings = recipe.servings[i];
            NSLog(@"serving size = %@", recipeServings.servingSize);
            NSLog(@"calories = %f", recipeServings.caloriesValue);
            NSLog(@"carbohydrates = %f", recipeServings.carbohydrateValue);
            NSLog(@"proteins = %f", recipeServings.proteinValue);
            NSLog(@"fats = %f", recipeServings.fatValue);
        }
        for (int i = 0; i < [recipe.ingredients count]; i++) {
            FSRecipeIngredients *recipeIngredients = recipe.ingredients[i];
            NSLog(@"ingredient %i = %@", i, recipeIngredients.ingredientDescription);
        }
        for (int i = 0; i < [recipe.directions count]; i++) {
            FSRecipeDirections *recipeDirections = recipe.directions[i];
            NSLog(@"direction %i = %@", i, recipeDirections.directionDescription);
        }
    }];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeSampleTableViewCell *cell = (RecipeSampleTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"RecipeSampleCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.myTitleLabel.font = [UIFont fontWithName:@"Oswald-Light" size:18];
    cell.myTitleLabel.textColor = [UIColor whiteColor];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row) {
        {case 0:
            NSLog(@"");
            UIImageView *titleBoxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, 320, 38)];
            titleBoxImageView.image = [UIImage imageNamed:@"title_rectangle@2x.png"];
            
            UILabel *foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 100, 40)];
            foodNameLabel.font = [UIFont fontWithName:@"Oswald" size:13];
            foodNameLabel.textColor = [UIColor whiteColor];
            foodNameLabel.text = [myRecipe.name uppercaseString];
            [foodNameLabel sizeToFit];
            foodNameLabel.frame = CGRectMake((320 - foodNameLabel.frame.size.width)/2, 8, foodNameLabel.frame.size.width, foodNameLabel.frame.size.height);
            
            [cell.contentView addSubview:titleBoxImageView];
            [titleBoxImageView addSubview:foodNameLabel];
            
            UIImageView *dividerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 138, 320, 10)];
            dividerImageView.image = [UIImage imageNamed:@"divider@2x.png"];
            
            UILabel *prepTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 150, 60, 40)];
            prepTimeLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            prepTimeLabel.textColor = [UIColor whiteColor];
            prepTimeLabel.text = @"PREP TIME";
            [prepTimeLabel sizeToFit];
            prepTimeLabel.frame = CGRectMake( (((320/3)/2) - prepTimeLabel.frame.size.width/2) , 150, prepTimeLabel.frame.size.width, prepTimeLabel.frame.size.height);
            
            UILabel *cookTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(136, 150, 60, 40)];
            cookTimeLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            cookTimeLabel.textColor = [UIColor whiteColor];
            cookTimeLabel.text = @"COOK TIME";
            [cookTimeLabel sizeToFit];
            cookTimeLabel.frame = CGRectMake( (((320/3)/2) - cookTimeLabel.frame.size.width/2) + ((320/3) * 1) , 150, cookTimeLabel.frame.size.width, cookTimeLabel.frame.size.height);
            
            UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(236, 150, 60, 40)];
            totalTimeLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            totalTimeLabel.textColor = [UIColor whiteColor];
            totalTimeLabel.text = @"TOTAL TIME";
            [totalTimeLabel sizeToFit];
            totalTimeLabel.frame = CGRectMake( (((320/3)/2) - totalTimeLabel.frame.size.width/2) + ((320/3) * 2) , 150, totalTimeLabel.frame.size.width, totalTimeLabel.frame.size.height);
            
            UIImageView *divider2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 218, 320, 10)];
            divider2ImageView.image = [UIImage imageNamed:@"divider@2x.png"];
            
            UILabel *calorieLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 230, 60, 40)];
            calorieLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            calorieLabel.textColor = [UIColor whiteColor];
            calorieLabel.text = @"CALORIES";
            [calorieLabel sizeToFit];
            calorieLabel.frame = CGRectMake((40 - (calorieLabel.frame.size.width/2)), 230, calorieLabel.frame.size.width, calorieLabel.frame.size.height);
            
            UILabel *proteinLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 230, 60, 40)];
            proteinLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            proteinLabel.textColor = [UIColor whiteColor];
            proteinLabel.text = @"PROTEINS";
            [proteinLabel sizeToFit];
            proteinLabel.frame = CGRectMake((120 - (proteinLabel.frame.size.width/2)), 230, proteinLabel.frame.size.width, proteinLabel.frame.size.height);
            
            UILabel *carbsLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 230, 60, 40)];
            carbsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            carbsLabel.textColor = [UIColor whiteColor];
            carbsLabel.text = @"CARBS";
            [carbsLabel sizeToFit];
            carbsLabel.frame = CGRectMake((200 - (carbsLabel.frame.size.width/2)), 230, carbsLabel.frame.size.width, carbsLabel.frame.size.height);
            
            UILabel *fatsLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 230, 60, 40)];
            fatsLabel.font = [UIFont fontWithName:@"Oswald-Light" size:12];
            fatsLabel.textColor = [UIColor whiteColor];
            fatsLabel.text = @"FATS";
            [fatsLabel sizeToFit];
            fatsLabel.frame = CGRectMake((280 - (fatsLabel.frame.size.width/2)), 230, fatsLabel.frame.size.width, fatsLabel.frame.size.height);
            
            [[FSClient sharedClient] getRecipe:myRecipe.identifier completion:^(FSRecipe *recipe) {
                UILabel *prepMinLabel = [[UILabel alloc] init];
                prepMinLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                prepMinLabel.textColor = [UIColor whiteColor];
                prepMinLabel.text = [NSString stringWithFormat:@"%li", (long)recipe.preparationTimeMin];
                [prepMinLabel sizeToFit];
                
                UILabel *prepMinLabelLabel = [[UILabel alloc] init];
                prepMinLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                prepMinLabelLabel.textColor = [UIColor whiteColor];
                prepMinLabelLabel.text = @" MIN";
                [prepMinLabelLabel sizeToFit];
                
                prepMinLabel.frame = CGRectMake( ((320/3)/2) - ((prepMinLabel.frame.size.width + prepMinLabelLabel.frame.size.width)/2), 101, prepMinLabel.frame.size.width, prepMinLabel.frame.size.height);
                prepMinLabelLabel.frame = CGRectMake(prepMinLabel.frame.origin.x
                                                     + prepMinLabel.frame.size.width, 120, prepMinLabelLabel.frame.size.width, prepMinLabelLabel.frame.size.height);
                
                UILabel *cookMinLabel = [[UILabel alloc] init];
                cookMinLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                cookMinLabel.textColor = [UIColor whiteColor];
                cookMinLabel.text = [NSString stringWithFormat:@"%li", (long)recipe.cookingTimeMin];
                NSLog(@"cooking time = %li", (long)recipe.cookingTimeMin);
                [cookMinLabel sizeToFit];
                
                UILabel *cookMinLabelLabel = [[UILabel alloc] init];
                cookMinLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                cookMinLabelLabel.textColor = [UIColor whiteColor];
                cookMinLabelLabel.text = @" MIN";
                [cookMinLabelLabel sizeToFit];
                
                cookMinLabel.frame = CGRectMake( ((320/3)/2) - ((cookMinLabel.frame.size.width + cookMinLabelLabel.frame.size.width)/2) + ((320/3) * 1), 101, cookMinLabel.frame.size.width, cookMinLabel.frame.size.height);
                cookMinLabelLabel.frame = CGRectMake(cookMinLabel.frame.origin.x
                                                     + cookMinLabel.frame.size.width, 120, cookMinLabelLabel.frame.size.width, cookMinLabelLabel.frame.size.height);
                
                UILabel *totalMinLabel = [[UILabel alloc] init];
                totalMinLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                totalMinLabel.textColor = [UIColor whiteColor];
                totalMinLabel.text = [NSString stringWithFormat:@"%li", ((long)recipe.cookingTimeMin + (long)recipe.preparationTimeMin)];
                [totalMinLabel sizeToFit];
                
                UILabel *totalMinLabelLabel = [[UILabel alloc] init];
                totalMinLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                totalMinLabelLabel.textColor = [UIColor whiteColor];
                totalMinLabelLabel.text = @" MIN";
                [totalMinLabelLabel sizeToFit];
                
                totalMinLabel.frame = CGRectMake( ((320/3)/2) - ((totalMinLabel.frame.size.width + totalMinLabelLabel.frame.size.width)/2) + ((320/3) * 2), 101, totalMinLabel.frame.size.width, totalMinLabel.frame.size.height);
                totalMinLabelLabel.frame = CGRectMake(totalMinLabel.frame.origin.x
                                                     + totalMinLabel.frame.size.width, 120, totalMinLabelLabel.frame.size.width, totalMinLabelLabel.frame.size.height);

                [cell.contentView addSubview:prepMinLabel];
                [cell.contentView addSubview:prepMinLabelLabel];
                [cell.contentView addSubview:cookMinLabel];
                [cell.contentView addSubview:cookMinLabelLabel];
                [cell.contentView addSubview:totalMinLabel];
                [cell.contentView addSubview:totalMinLabelLabel];
                
                if ([recipe.servings count] != 0) {
                    FSRecipeServings *recipeServings = recipe.servings[0];
                    
                    UILabel *caloriesLabel = [[UILabel alloc] init];
                    caloriesLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                    caloriesLabel.textColor = [UIColor whiteColor];
                    caloriesLabel.text = [NSString stringWithFormat:@"%.f", recipeServings.caloriesValue];
                    [caloriesLabel sizeToFit];
                    caloriesLabel.frame = CGRectMake(40 - (caloriesLabel.frame.size.width/2), 181, caloriesLabel.frame.size.width, caloriesLabel.frame.size.height);
                    
                    UILabel *proteinsLabel = [[UILabel alloc] init];
                    proteinsLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                    proteinsLabel.textColor = [UIColor whiteColor];
                    proteinsLabel.text = [NSString stringWithFormat:@"%.f", recipeServings.proteinValue];
                    [proteinsLabel sizeToFit];
                    
                    UILabel *proteinsLabelLabel = [[UILabel alloc] init];
                    proteinsLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                    proteinsLabelLabel.textColor = [UIColor whiteColor];
                    proteinsLabelLabel.text = @" g";
                    [proteinsLabelLabel sizeToFit];
                    
                    proteinsLabel.frame = CGRectMake(120 - ((proteinsLabel.frame.size.width + proteinsLabelLabel.frame.size.width)/2), 181, proteinsLabel.frame.size.width, proteinsLabel.frame.size.height);
                    proteinsLabelLabel.frame = CGRectMake(proteinsLabel.frame.origin.x + proteinsLabel.frame.size.width, 200, proteinsLabelLabel.frame.size.width, proteinsLabelLabel.frame.size.height);
                    
                    UILabel *carbsLabel = [[UILabel alloc] init];
                    carbsLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                    carbsLabel.textColor = [UIColor whiteColor];
                    carbsLabel.text = [NSString stringWithFormat:@"%.f", recipeServings.carbohydrateValue];
                    [carbsLabel sizeToFit];
                    
                    UILabel *carbsLabelLabel = [[UILabel alloc] init];
                    carbsLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                    carbsLabelLabel.textColor = [UIColor whiteColor];
                    carbsLabelLabel.text = @" g";
                    [carbsLabelLabel sizeToFit];
                    
                    carbsLabel.frame = CGRectMake(200 - ((carbsLabel.frame.size.width + carbsLabelLabel.frame.size.width)/2), 181, carbsLabel.frame.size.width, carbsLabel.frame.size.height);
                    carbsLabelLabel.frame = CGRectMake(carbsLabel.frame.origin.x + carbsLabel.frame.size.width, 200, carbsLabelLabel.frame.size.width, carbsLabelLabel.frame.size.height);
                    
                    UILabel *fatsLabel = [[UILabel alloc] init];
                    fatsLabel.font = [UIFont fontWithName:@"Oswald" size:30];
                    fatsLabel.textColor = [UIColor whiteColor];
                    fatsLabel.text = [NSString stringWithFormat:@"%.f", recipeServings.fatValue];
                    [fatsLabel sizeToFit];
                    
                    UILabel *fatsLabelLabel = [[UILabel alloc] init];
                    fatsLabelLabel.font = [UIFont fontWithName:@"Oswald" size:14];
                    fatsLabelLabel.textColor = [UIColor whiteColor];
                    fatsLabelLabel.text = @" g";
                    [fatsLabelLabel sizeToFit];
                    
                    fatsLabel.frame = CGRectMake(280 - ((fatsLabel.frame.size.width + fatsLabelLabel.frame.size.width)/2), 181, fatsLabel.frame.size.width, fatsLabel.frame.size.height);
                    fatsLabelLabel.frame = CGRectMake(fatsLabel.frame.origin.x + fatsLabel.frame.size.width, 200, fatsLabelLabel.frame.size.width, fatsLabelLabel.frame.size.height);
                    
                    [cell.contentView addSubview:caloriesLabel];
                    [cell.contentView addSubview:proteinsLabel];
                    [cell.contentView addSubview:proteinsLabelLabel];
                    [cell.contentView addSubview:carbsLabel];
                    [cell.contentView addSubview:carbsLabelLabel];
                    [cell.contentView addSubview:fatsLabel];
                    [cell.contentView addSubview:fatsLabelLabel];
                }
            }];
            
            [cell.contentView addSubview:dividerImageView];
            [cell.contentView addSubview:prepTimeLabel];
            [cell.contentView addSubview:cookTimeLabel];
            [cell.contentView addSubview:totalTimeLabel];
            [cell.contentView addSubview:divider2ImageView];
            [cell.contentView addSubview:calorieLabel];
            [cell.contentView addSubview:proteinLabel];
            [cell.contentView addSubview:carbsLabel];
            [cell.contentView addSubview:fatsLabel];
            break;}
        {case 1:
            NSLog(@"");
            [[FSClient sharedClient] getRecipe:myRecipe.identifier completion:^(FSRecipe *recipe) {
                UILabel *servingsLabel = [[UILabel alloc] init];
                servingsLabel.font = [UIFont fontWithName:@"Norican-Regular" size:16];
                servingsLabel.textColor = [UIColor whiteColor];
                servingsLabel.text = [NSString stringWithFormat:@"Makes %li servings", (long)recipe.numberOfServings];
                [servingsLabel sizeToFit];
                servingsLabel.frame = CGRectMake(54, 75, servingsLabel.frame.size.width, servingsLabel.frame.size.height);
                
                UITextView *ingredientsTextView = [[UITextView alloc] init];
                ingredientsTextView.backgroundColor = [UIColor clearColor];
                ingredientsTextView.frame = CGRectMake(60, 110, 220, 135);
                ingredientsTextView.scrollEnabled = YES;
                ingredientsTextView.pagingEnabled = NO;
                ingredientsTextView.editable = NO;
                ingredientsTextView.userInteractionEnabled = YES;
                ingredientsTextView.font = [UIFont fontWithName:@"Oswald-light" size:12];
                ingredientsTextView.textColor = [UIColor whiteColor];
                
                for (int i = 0; i < [recipe.ingredients count]; i++) {
                    FSRecipeIngredients *recipeIngredients = recipe.ingredients[i];
                    
                    ingredientsTextView.text = [NSString stringWithFormat:@"%@ %@", ingredientsTextView.text, recipeIngredients.ingredientDescription];
                    ingredientsTextView.text = [NSString stringWithFormat:@"%@ \n", ingredientsTextView.text];
                }
                
                [cell.contentView addSubview:servingsLabel];
                [cell.contentView addSubview:ingredientsTextView];
            }];
            break;}
        {case 2:
            NSLog(@"");
            [[FSClient sharedClient] getRecipe:myRecipe.identifier completion:^(FSRecipe *recipe) {
                UILabel *preparationLabel = [[UILabel alloc] init];
                preparationLabel.font = [UIFont fontWithName:@"Norican-Regular" size:16];
                preparationLabel.textColor = [UIColor whiteColor];
                preparationLabel.text = @"Preparation";
                [preparationLabel sizeToFit];
                preparationLabel.frame = CGRectMake(59, 76, preparationLabel.frame.size.width, preparationLabel.frame.size.height);
                
                UITextView *directionsTextView = [[UITextView alloc] init];
                directionsTextView.backgroundColor = [UIColor clearColor];
                directionsTextView.frame = CGRectMake(60, 110, 220, 135);
                directionsTextView.scrollEnabled = YES;
                directionsTextView.pagingEnabled = NO;
                directionsTextView.editable = NO;;
                directionsTextView.userInteractionEnabled = YES;
                directionsTextView.font = [UIFont fontWithName:@"Oswald-Light" size:12];
                directionsTextView.textColor = [UIColor whiteColor];
                
                for (int i = 0; i < [recipe.directions count]; i++) {
                    FSRecipeDirections *recipeDirections = recipe.directions[i];
                    directionsTextView.text = [NSString stringWithFormat:@"%@ %@", directionsTextView.text, recipeDirections.directionDescription];
                    directionsTextView.text = [NSString stringWithFormat:@"%@ \n \n", directionsTextView.text];
                    NSLog(@"test");
                }
                
                [cell.contentView addSubview:preparationLabel];
                [cell.contentView addSubview:directionsTextView];
            }];

            break;}
        {default:
            break;}
    }


    if (isFirstTime) {
        cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
        isFirstTime = NO;
    } else {
        cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFirstClick) {
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        RecipeSampleTableViewCell *cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:myIndexPath];
        cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
        isFirstClick = NO;
    }
    
    int row = (int)[indexPath row];
    currentSelection = row;
    
    RecipeSampleTableViewCell* cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"upArrow.png"];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeSampleTableViewCell* cell = (RecipeSampleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:@"downArrow.png"];
    cell.myTitleLabel.text = categoryArray[indexPath.row];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == currentSelection) {
        return 269;
    }
    else {
        return 55;
    }
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
