//
//  LogoutView.h
//  LoginCounter
//
//  Created by Eric Young Hoon Choi on 2/19/13.
//  Copyright (c) 2013 Eric Young Hoon Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutView : UIViewController

@property (nonatomic, strong) UITextView *messageBox;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) UIButton *logoutButton;

@end
