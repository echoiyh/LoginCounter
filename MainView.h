//
//  MainView.h
//  LoginCounter
//
//  Created by Eric Young Hoon Choi on 2/19/13.
//  Copyright (c) 2013 Eric Young Hoon Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "LogoutView.h"

@interface MainView : UIViewController

@property (nonatomic, strong) UITextView *messageBox;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UITextField *userNameText;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *passwordText;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *addUserButton;
@property (nonatomic, strong) AFHTTPClient *httpClient;

@end
