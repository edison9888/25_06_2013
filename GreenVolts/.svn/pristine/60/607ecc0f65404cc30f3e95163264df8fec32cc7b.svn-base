//
//  LoginViewController.h
//  GreenVolts
//
//  Created by YML on 8/26/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionFailedDelegate.h"

@protocol LoginViewControllerDelegate<NSObject>

-(void)LoginSuccess:(NSString *)sessionToken;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
  UITextField *m_UsernameTextfield;
  UITextField *m_PasswordTextField;
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  NSString *m_UserName,*m_Password;
  UIActivityIndicatorView *m_ActivityIndicatorView;
    
#ifdef AUTO_LOGIN
    UITextField *hiddenTextField;
#endif
}
@property(nonatomic,assign) id<LoginViewControllerDelegate> m_delegate;
@end
