//
//  RecipeViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 24/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "RecipeViewController.h"
#define YValueInitial 0

@interface RecipeViewController () {
    BOOL isExpanded;
    NSUInteger tagOfViewExpanded;
    NSArray *searchMethods;
    NSArray *mealTypes;
}
@end

@implementation RecipeViewController
@synthesize myAccordionScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchMethods = [NSArray new];
    searchMethods = @[@"SORT BY MEAL", @"SORT BY NAME"];
    mealTypes = [NSArray new];
    mealTypes = @[@"BREAKFAST", @"LUNCH", @"DINNER", @"DESSERT", @"SNACKS"];
    
    [self checkScreenSize];
    [self setTableOuter:2];    
}

-(void) checkScreenSize
// Checks whether the device is 3.5 inch, and if so reduces the height of the scrollView by 88
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if (screenBounds.size.height == 480) {
        myAccordionScrollView.frame  = CGRectMake(myAccordionScrollView.frame.origin.x, myAccordionScrollView.frame.origin.y, myAccordionScrollView.frame.size.width, myAccordionScrollView.frame.size.height-88);
    }
}

-(void)setTableOuter:(NSUInteger)noOfOuterRows {
    int yValue = YValueInitial;
    for (UIView *subview in myAccordionScrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < noOfOuterRows; i++) {
        UIButton *outerViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, yValue, 320, 50)];
        outerViewButton.tag = i + 1;
        [outerViewButton setBackgroundColor:[UIColor grayColor]];
        [outerViewButton addTarget:self action:@selector(outerViewButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *outerViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 14, 128, 21)];
        outerViewLabel.text = searchMethods[i];
        outerViewLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(286, 20, 12, 8)];
        arrowImageView.tag = 100;
        [arrowImageView setImage:[UIImage imageNamed:@"downArrow.png"]];
        
        [outerViewButton addSubview:outerViewLabel];
        [outerViewButton addSubview:arrowImageView];
        [myAccordionScrollView addSubview:outerViewButton];
        
        yValue = yValue + outerViewButton.frame.size.height + 3;
    }
    
    [myAccordionScrollView setContentSize:CGSizeMake(320, yValue)];
}

-(void)setTableInner:(NSUInteger)numberOfRows forViewWithTag:(NSUInteger)tagForView {
// To fix the animation change the addSubview commands to add the subview to a UIView. Then implement a transform animation that matched the speed of the upper menu view.
    
    float yValue = YValueInitial;
    float yValueForSubviews = 0;
    
    tagOfViewExpanded = tagForView;
    UIView *viewBelowWhichItStarts;
    NSMutableArray *subviewsArray = [myAccordionScrollView.subviews mutableCopy];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    [subviewsArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    for (UIView *subview in subviewsArray) {
        if (subview.tag == tagForView) {
            viewBelowWhichItStarts = subview;
            yValueForSubviews = viewBelowWhichItStarts.frame.origin.y + viewBelowWhichItStarts.frame.size.height;
        } else if (subview.tag == 0) {
            [subview removeFromSuperview];
        }
    }
    
    yValue = viewBelowWhichItStarts.frame.origin.y + 50;
    for (int i = 0; i < numberOfRows; i++) {
        
        UIButton *buttonForInnerTable = [[UIButton alloc] initWithFrame:CGRectMake(0, yValue, 320, 50)];
        UIView *borderForInnerTable = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 1)];
        [buttonForInnerTable addTarget:self action:@selector(innerViewButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [borderForInnerTable setBackgroundColor:[UIColor lightGrayColor]];
        yValue = yValue + buttonForInnerTable.frame.size.height;
        
        UIImageView *imageViewForInnerTable = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        [imageViewForInnerTable setBackgroundColor:[UIColor blackColor]];
        imageViewForInnerTable.layer.cornerRadius = imageViewForInnerTable.frame.size.height/2;
        imageViewForInnerTable.layer.masksToBounds = YES;
        imageViewForInnerTable.layer.borderWidth = 0;
        
        UILabel *labelForInnerTable = [[UILabel alloc] initWithFrame:CGRectMake(77, 18, 69, 14)];
        [labelForInnerTable setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *countForInnerTable = [[UILabel alloc] initWithFrame:CGRectMake(268, 16, 32, 17)];
        [countForInnerTable setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        
        if (tagForView == 1) {
            labelForInnerTable.text = mealTypes[i];
            [labelForInnerTable sizeToFit];
            countForInnerTable.text = [NSString stringWithFormat:@"(%i)", arc4random() % 999];
            [countForInnerTable sizeToFit];
        }
        
        [myAccordionScrollView addSubview:buttonForInnerTable];
        [buttonForInnerTable addSubview:borderForInnerTable];
        [buttonForInnerTable addSubview:imageViewForInnerTable];
        [buttonForInnerTable addSubview:labelForInnerTable];
        [buttonForInnerTable addSubview:countForInnerTable];
    }
    
    yValueForSubviews = yValue;
    for (UIView *subview in subviewsArray) {
        if (subview.tag > tagForView) {
            [myAccordionScrollView bringSubviewToFront:subview];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            subview.frame = CGRectMake(0, yValueForSubviews, 320, viewBelowWhichItStarts.frame.size.height);
            [UIView commitAnimations];
            
            yValueForSubviews = yValueForSubviews + viewBelowWhichItStarts.frame.size.height;
        }
    }
    
    [myAccordionScrollView setContentSize:CGSizeMake(320, yValueForSubviews + 2)];
}

-(void)outerViewButtonTouched:(UIButton *)sender {
    for (UIView *outerView in myAccordionScrollView.subviews) {
        if (outerView.tag > 0) {
            for (UIView *subview in outerView.subviews) {
                if ([subview isMemberOfClass:[UIButton class]]) {
                    ((UIButton *)subview).selected = NO;
                }
            }
        }
    }
    if (!isExpanded) {
        isExpanded = YES;
        sender.selected = YES;
        for (UIImageView *imageView in sender.subviews) {
            if (imageView.tag == 100) {
                [imageView setImage:[UIImage imageNamed:@"upArrow.png"]];
            }
        }
        if (sender.tag == 1) {
            [self setTableInner:mealTypes.count forViewWithTag:sender.tag];
        } else {
            [self setTableInner:10 forViewWithTag:sender.tag];
        }

    } else {
        isExpanded = NO;
        if (sender.tag == tagOfViewExpanded) {
            sender.selected = NO;
            [self bringUpViews:tagOfViewExpanded];
        } else {
            sender.selected = YES;
            [self bringUpViews:tagOfViewExpanded];
            for (UIImageView *imageView in sender.subviews) {
                if (imageView.tag == 100) {
                    [imageView setImage:[UIImage imageNamed:@"upArrow.png"]];
                }
            }
            if (sender.tag == 1) {
                [self setTableInner:mealTypes.count forViewWithTag:sender.tag];
            } else {
                [self setTableInner:10 forViewWithTag:sender.tag];
            }
            isExpanded = YES;
        }
    }
}

-(void)bringUpViews:(NSUInteger)tagForView {
    UIView *viewBelowWhichItStarts;
    float yValueForSubviews = 0.0;
    
    for (UIView *subview in myAccordionScrollView.subviews) {
        if (subview.tag == tagForView) {
            for (UIImageView *imageView in subview.subviews) {
                if (imageView.tag == 100) {
                    [imageView setImage:[UIImage imageNamed:@"downArrow.png"]];
                }
            }
            viewBelowWhichItStarts = subview;
            yValueForSubviews = viewBelowWhichItStarts.frame.origin.y + 50;
        }
        if (subview.tag > tagForView) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            subview.frame = CGRectMake(0, yValueForSubviews + 3, 320, viewBelowWhichItStarts.frame.size.height);
            [UIView commitAnimations];
            yValueForSubviews = yValueForSubviews + viewBelowWhichItStarts.frame.size.height;
        }
    }
    [myAccordionScrollView setContentSize:CGSizeMake(320, yValueForSubviews)];
    yValueForSubviews = viewBelowWhichItStarts.frame.origin.y;
    [myAccordionScrollView bringSubviewToFront:viewBelowWhichItStarts];
    float yCheck = yValueForSubviews;
    
    for (UIView *subview in myAccordionScrollView.subviews) {
        if (subview.tag == 0) {
            if ((subview.frame.origin.y - yCheck) == 50) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.3];
                subview.frame = CGRectMake(0, yValueForSubviews, 320, viewBelowWhichItStarts.frame.size.height);
                [UIView commitAnimations];
                yCheck += 50;
            }
        }
    }
}

-(void)innerViewButtonTouched:(id)sender {
    [self performSegueWithIdentifier:@"RecipeSampleSegue" sender:self];
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
