//
//  MainView.m
//  LoginCounter
//
//  Created by Eric Young Hoon Choi on 2/19/13.
//  Copyright (c) 2013 Eric Young Hoon Choi. All rights reserved.
//

#import "MainView.h"
#import "QuartzCore/QuartzCore.h"

@interface MainView ()

@end

@implementation MainView

- (id)init
{
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAllTheButtonsAndLabels];
    self.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://pure-crag-2400.herokuapp.com/"]];
    [self.httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    self.httpClient.parameterEncoding = AFJSONParameterEncoding;
}

- (void)setupAllTheButtonsAndLabels //change the method name
{
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 119, 118, 21)];
    self.userNameLabel.text = @"Username: ";
    self.userNameLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    [self.view addSubview: self.userNameLabel];
    
    self.userNameText = [[UITextField alloc] initWithFrame:CGRectMake(117, 117, 183, 30)];
    self.userNameText.borderStyle = UITextBorderStyleRoundedRect;
    self.userNameText.delegate = self;
    [self.view addSubview:self.userNameText];
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 166, 118, 21)];
    self.passwordLabel.text = @"Password: ";
    self.passwordLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    [self.view addSubview: self.passwordLabel];
    
    self.passwordText = [[UITextField alloc] initWithFrame:CGRectMake(117, 162, 183, 30)];
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.delegate = self;
    [self.view addSubview:self.passwordText];
    
    self.messageBox = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 73)];
    self.messageBox.text = @"Please enter your credentials below";
    self.messageBox.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    self.messageBox.layer.borderWidth = 1.0f;
    self.messageBox.editable = NO;
    self.messageBox.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:self.messageBox];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(20, 247, 131, 49);
    [self.loginButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    self.addUserButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addUserButton setTitle:@"Add User" forState:UIControlStateNormal];
    self.addUserButton.frame = CGRectMake(169, 247, 131, 49);
    [self.addUserButton addTarget:self action:@selector(addUserPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addUserButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) loginPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.userNameText.text,
                            @"user", self.passwordText.text, @"password", nil];
    [self.httpClient postPath:@"/users/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LogoutView *logout = [[LogoutView alloc] init];
                logout.userName = self.userNameText.text;
                logout.count = count;
                [self presentViewController:logout animated:YES completion:nil];
            }
                break;
            case -1:
            {
                self.messageBox.text = @"Invalid username and password combination. Please try again.";
            }
                break;
            default:
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) addUserPressed
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.userNameText.text,
                            @"user", self.passwordText.text, @"password", nil];
    [self.httpClient postPath:@"/users/add" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        int errCode = ((NSString *)[responseObject objectForKey:@"errCode"]).intValue;
        switch (errCode) {
            case 1:
            {
                int count = ((NSString *) [responseObject objectForKey:@"count"]).intValue;
                LogoutView *logout = [[LogoutView alloc] init];
                logout.userName = self.userNameText.text;
                logout.count = count;
                [self presentViewController:logout animated:YES completion:nil];
            }
                break;
            case -2:
            {
                [self.messageBox setText:@"This user name already exists. Please try again."];
            }
                break;
            case -3:
            {
                self.messageBox.text = @"The user name should be non-empty and at most 128 characters long. Please try again.";
            }
                break;
            case -4:
            {
                self.messageBox.text = @"The password should be at most 128 characters long. Please try again.";
            }
                break;
            default:
                break;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

@end
