//
//  ParseSignUpViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 15/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewController.h"

@interface ParseSignUpViewController () <UIScrollViewDelegate>

@end

@implementation ParseSignUpViewController
@synthesize myScrollView, stepsLeftLabel, progressView, completedProgressView, stepLabel, instructionLabel, roundedRectangleImageView, nextStepButton, page, pages, instructionArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pages = 5;
    instructionArray = @[@"Enter Current Weight", @"Enter Height", @"Select Gender", @"Select Activity Level", @"Enter Target Weight"];
    
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width * (float)pages, myScrollView.frame.size.height);
    
    completedProgressView = [[UIView alloc] initWithFrame:CGRectMake(10, 61, 300, 4)];
    [completedProgressView setBackgroundColor:[UIColor blackColor]];
    [myScrollView addSubview:completedProgressView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = myScrollView.frame.size.width;
    page = (myScrollView.contentOffset.x + (0.5f * pageWidth))/pageWidth;
    NSLog(@"page = %i", page);
    
    stepsLeftLabel.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    progressView.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    stepLabel.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    instructionLabel.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    roundedRectangleImageView.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    nextStepButton.transform = CGAffineTransformMakeTranslation(myScrollView.contentOffset.y, 0);
    
    switch (page) {
        case 0:
            stepsLeftLabel.text = [NSString stringWithFormat:@"%i short steps to a sexier you", pages - page];
            [completedProgressView setFrame:CGRectMake(completedProgressView.frame.origin.x, completedProgressView.frame.origin.y, (completedProgressView.frame.size.width/pages * (page + 1)), completedProgressView.frame.size.height)];
            stepLabel.text = [NSString stringWithFormat:@"Step %i", page];
            instructionLabel.text = [NSString stringWithFormat:@"%@", instructionArray[page]];
            break;
        case 1:
            stepsLeftLabel.text = [NSString stringWithFormat:@"%i short steps to a sexier you", pages - page];
            [completedProgressView setFrame:CGRectMake(completedProgressView.frame.origin.x, completedProgressView.frame.origin.y, (completedProgressView.frame.size.width/pages * (page + 1)), completedProgressView.frame.size.height)];
            stepLabel.text = [NSString stringWithFormat:@"Step %i", page];
            instructionLabel.text = [NSString stringWithFormat:@"%@", instructionArray[page]];
            break;
        case 2:
            stepsLeftLabel.text = [NSString stringWithFormat:@"%i short steps to a sexier you", pages - page];
            [completedProgressView setFrame:CGRectMake(completedProgressView.frame.origin.x, completedProgressView.frame.origin.y, (completedProgressView.frame.size.width/pages * (page + 1)), completedProgressView.frame.size.height)];
            stepLabel.text = [NSString stringWithFormat:@"Step %i", page];
            instructionLabel.text = [NSString stringWithFormat:@"%@", instructionArray[page]];
            break;
        case 3:
            stepsLeftLabel.text = [NSString stringWithFormat:@"%i short steps to a sexier you", pages - page];
            [completedProgressView setFrame:CGRectMake(completedProgressView.frame.origin.x, completedProgressView.frame.origin.y, (completedProgressView.frame.size.width/pages * (page + 1)), completedProgressView.frame.size.height)];
            stepLabel.text = [NSString stringWithFormat:@"Step %i", page];
            instructionLabel.text = [NSString stringWithFormat:@"%@", instructionArray[page]];
            break;
        case 4:
            stepsLeftLabel.text = [NSString stringWithFormat:@"%i more step to a sexier you", pages - page];
            [completedProgressView setFrame:CGRectMake(completedProgressView.frame.origin.x, completedProgressView.frame.origin.y, (completedProgressView.frame.size.width/pages * (page + 1)), completedProgressView.frame.size.height)];
            stepLabel.text = [NSString stringWithFormat:@"Step %i", page];
            instructionLabel.text = [NSString stringWithFormat:@"%@", instructionArray[page]];
            break;
        default:
            break;
    }
}



- (IBAction)nextStepButtonTouched:(id)sender {
    NSLog(@"Touch!!");
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
