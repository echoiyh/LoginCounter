//
//  LogoutView.m
//  LoginCounter
//
//  Created by Eric Young Hoon Choi on 2/19/13.
//  Copyright (c) 2013 Eric Young Hoon Choi. All rights reserved.
//

#import "LogoutView.h"
#import "QuartzCore/QuartzCore.h"

@interface LogoutView ()

@end

@implementation LogoutView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

-(void)setupViews
{
    self.messageBox = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 73)];
    self.messageBox.text = [NSString stringWithFormat:@"Welcome %@. You have logged in %i times.", self.userName, self.count];
    self.messageBox.layer.borderWidth = 1.0f;
    self.messageBox.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:self.messageBox];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    self.logoutButton.frame = CGRectMake(95, 166, 131, 49);
    [self.logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
}

-(void)logoutAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
