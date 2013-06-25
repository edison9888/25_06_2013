//
//  LoginManager.h
//  GreenVolts
//
//  Created by YML on 21/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
@protocol LoginManagerDelegate;
@interface LoginManager : NSObject
{
  LoginViewController *mLoginViewController;
  BOOL isLoginDialogShown;
}
+(LoginManager*)sharedLoginManagerWithDelegate:(id<LoginManagerDelegate>)Delegate;
-(void)ShowLoginPage;
@end


@protocol LoginManagerDelegate<NSObject>
-(void)loginManager:(LoginManager*)manager loggedInSuccesfullyWithSessionToken:(NSString*)sessionToken;
@optional
-(void)loginManagerFoundNoRootViewController;
@end