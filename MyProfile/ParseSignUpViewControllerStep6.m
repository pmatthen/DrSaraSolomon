//
//  ParseSignUpViewControllerStep6.m
//  MyProfile
//
//  Created by Poulose Matthen on 30/07/14.
//  Copyright (c) 2014 Dr. Sara Solomon Fitness. All rights reserved.
//

#import "ParseSignUpViewControllerStep6.h"
#import "ParseSignUpViewControllerStep7.h"

@interface ParseSignUpViewControllerStep6 ()

@end

@implementation ParseSignUpViewControllerStep6
@synthesize inchesHeight, weight, gender, neat, username, password;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"name = %@, email = %@, username = %@, password = %@, weight = %i, inchesHeight = %i, gender = %i, neat = %i", self.name, self.email, self.username, self.password, self.weight, self.inchesHeight, self.gender, self.neat);

    UILabel *congratsLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 190, 150, 150)];
    congratsLabel.font = [UIFont fontWithName:@"Norican-Regular" size:37];
    congratsLabel.textColor = [UIColor whiteColor];
    congratsLabel.text = @"Congratulations!";
    [congratsLabel sizeToFit];
    
    UILabel *getReadyLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 143, 250, 300)];
    getReadyLabel.font = [UIFont fontWithName:@"Oswald-Light" size:16];
    getReadyLabel.textColor = [UIColor whiteColor];
    getReadyLabel.textAlignment = NSTextAlignmentCenter;
    getReadyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    getReadyLabel.numberOfLines = 0;
    getReadyLabel.text = @"You are now a member of the Sara Solomon Intermittent Fasting and Calorie Tracking app! Get ready to look and feel sexier than you ever have before!";
    
    [self.view addSubview:congratsLabel];
    [self.view addSubview:getReadyLabel];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)backButtonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)startGettingSexyButtonTouched:(id)sender {
    // Retrieve the object by id
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        if (!error) {
            user[@"height"] = [NSNumber numberWithInt:inchesHeight];
            user[@"weight"] = [NSNumber numberWithInt:weight];
            user[@"gender"] = [NSNumber numberWithInt:gender];
            user[@"neat"] = [NSNumber numberWithInt:neat];
            
            [user saveInBackground];
            [self performSegueWithIdentifier:@"NextStepSegue" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"error = %@", errorString);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"There was an error in the signup process, %@.", errorString] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ParseSignUpViewControllerStep7 *nextStepController = (ParseSignUpViewControllerStep7 *) segue.destinationViewController;
    
    nextStepController.name = self.name;
    nextStepController.email = self.email;
    nextStepController.username = self.username;
    nextStepController.password = self.password;
    nextStepController.weight = self.weight;
    nextStepController.inchesHeight = self.inchesHeight;
    nextStepController.gender = self.gender;
    nextStepController.neat = self.neat;
}

@end
