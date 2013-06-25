//
//  ConnectionFailedDelegate.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionFailedDelegate.h"

@implementation ConnectionFailedDelegate
@synthesize m_Login;

-(id) init {
    if (self = [super init])
        m_Login = [[LoginViewController alloc]init];
    return self;
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController pushViewController:m_Login animated:YES];    
}

@end
