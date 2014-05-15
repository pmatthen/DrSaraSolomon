//
//  InitialViewController.m
//  MyProfile
//
//  Created by Vanaja Matthen on 14/05/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "InitialViewController.h"
#import "InitialViewControlllerTableViewCell.h"

@interface InitialViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation InitialViewController
@synthesize myImage, myImageView, myImageViewArray, myScrollView, myPageControl, myTableView, choiceArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    choiceArray = @[@"Sign Up Today", @"Already a member? Sign In"];
    
    CGFloat width = 0.0;
    
    myImageViewArray = @[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page1.png"]], [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page2.png"]], [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page3.png"]]];
    
    for (UIImageView *tempImageView in myImageViewArray) {
        tempImageView.frame = CGRectMake(width, 0, self.view.frame.size.width, self.view.frame.size.height);
        [tempImageView setBackgroundColor:[UIColor redColor]];
        [myScrollView addSubview:tempImageView];
        width += tempImageView.frame.size.width;
    }
    
    myScrollView.contentSize = CGSizeMake(width, myScrollView.frame.size.height);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = myScrollView.frame.size.width;
    int page = (myScrollView.contentOffset.x + (0.5f * pageWidth))/pageWidth;
    NSLog(@"page = %i", page);
    myPageControl.currentPage = page;
}

-(InitialViewControlllerTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InitialViewControlllerTableViewCell *cell = (InitialViewControlllerTableViewCell *)[myTableView dequeueReusableCellWithIdentifier:@"ChoiceCell"];
    
    cell.choiceTitleLabel.text = choiceArray[indexPath.row];
    if (indexPath.row == 1) {
        [cell.choiceTitleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [choiceArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"LogInSegue" sender:self];        
    }
}

@end
