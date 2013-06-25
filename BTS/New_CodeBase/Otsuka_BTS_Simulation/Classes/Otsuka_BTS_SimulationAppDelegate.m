//
//  Otsuka_BTS_SimulationAppDelegate.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/24/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "Otsuka_BTS_SimulationAppDelegate.h"
#import "ShellViewController.h"

@implementation Otsuka_BTS_SimulationAppDelegate

@synthesize window, shellVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch
	
	ShellViewController *svc = [[ShellViewController alloc] initWithNibName:@"ShellViewController" bundle:nil];
	
	shellVC = [svc retain];	
	[window addSubview:shellVC.view];
	[svc release];
	
	[shellVC initActivity];	
	
    [window makeKeyAndVisible];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"Enter your First Name and Last Name and click Login to begin."
                                                       delegate:self
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    
    return YES;
}

- (void)dealloc {
    [window release];
	[shellVC release];
    [super dealloc];
}


@end
