//
//  LoginManager.m
//  GreenVolts
//
//  Created by YML on 21/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "LoginManager.h"

#import "GreenVoltsAppDelegate.h"

static LoginManager *_instance=nil;

@interface LoginManager()<LoginViewControllerDelegate>

@property(nonatomic,assign)id<LoginManagerDelegate> delegate;
@end

@implementation LoginManager
@synthesize delegate;

+(LoginManager*)sharedLoginManagerWithDelegate:(id<LoginManagerDelegate>)Delegate;
{
  if(!_instance)
  {
    _instance=[[LoginManager alloc]init];
  }
  _instance.delegate=Delegate;
  return _instance;
}
-(void)ShowLoginPage
{
  if(isLoginDialogShown)
    return;
  if(mLoginViewController)
  {
    mLoginViewController.m_delegate=nil;
    mLoginViewController=nil;
  }
  mLoginViewController=[[LoginViewController alloc]init];
  mLoginViewController.m_delegate=self;
  GreenVoltsAppDelegate *appDelegate=(GreenVoltsAppDelegate *)[UIApplication sharedApplication].delegate;
  assert(appDelegate.RootViewController);
  [appDelegate.RootViewController presentModalViewController:mLoginViewController animated:NO];
  isLoginDialogShown=YES;
}

#pragma mark -- LoginViewControllerDelegate
-(void)LoginSuccess:(NSString *)sessionToken
{
  isLoginDialogShown=NO;
  [[UIApplication sharedApplication].keyWindow.rootViewController dismissModalViewControllerAnimated:NO];
  mLoginViewController.m_delegate=nil;
  mLoginViewController=nil;
  if(delegate)
  {
    if([delegate respondsToSelector:@selector(loginManager:loggedInSuccesfullyWithSessionToken:)])
      [delegate loginManager:self loggedInSuccesfullyWithSessionToken:sessionToken];
  }
  delegate=nil;
}
@end
