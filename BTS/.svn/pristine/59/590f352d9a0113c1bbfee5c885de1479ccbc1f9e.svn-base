    //
//  Profile.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Profile.h"
#import "ShellViewController.h"

@implementation Profile

@synthesize yourProfile, yourCustomer, yourMentor, yourRole;
@synthesize yourDescription, customerDescription, mentorDescription, roleDescription, mentor;
@synthesize listOfViews, listOfWebViews;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	//NSLog(@"comes in profile");
	[self.view setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
	listOfViews = [NSDictionary dictionaryWithObjectsAndKeys:yourProfile, @"Your Profile", yourCustomer, @"Your Customer", 
				   yourMentor, @"Your Mentor", yourRole, @"Your Role", nil];
	listOfWebViews = [NSDictionary dictionaryWithObjectsAndKeys:yourDescription, @"Your Profile", customerDescription, @"Your Customer", 
				   mentorDescription, @"Your Mentor", roleDescription, @"Your Role", nil];
	
    [super viewDidLoad];
}

- (void) loadViewWithName:(NSString *) viewName andContent:content {
	NSArray *profileContent = content;
	int profileCount = [[[profileContent objectAtIndex:0] objectAtIndex:1] count];
	for (int i = 0; i<profileCount; i++) {
		if ([[[[[[profileContent objectAtIndex:0] objectAtIndex:1] objectAtIndex:i] objectAtIndex:0] objectForKey:@"title"] isEqual:viewName]) {
            int descriptionIndex = 1;
            if ([viewName isEqualToString:@"Your Role"]) {
                descriptionIndex = [ShellViewController getCurrentRound] + 1;
            }
			[self.view addSubview:[listOfViews objectForKey:viewName]];
			[[listOfViews objectForKey:viewName] setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
			[[listOfWebViews objectForKey:viewName] loadHTMLString:[[[[[profileContent objectAtIndex:0] objectAtIndex:1] objectAtIndex:i] objectAtIndex:descriptionIndex] objectForKey:@"descriptionText"] baseURL:[NSURL URLWithString:@""]];
			// To disable overscrolling
			UIScrollView *scrollView = nil;
			for(UIView *aView in [[listOfWebViews objectForKey:viewName] subviews]){
				if([aView isKindOfClass:[UIScrollView class] ]){
					scrollView = (UIScrollView *)aView;
					//scrollView.scrollEnabled = NO;
					scrollView.bounces = NO;
				}
			}
			// To remove black background while scrolling
			[[listOfWebViews objectForKey:viewName] setBackgroundColor:[UIColor clearColor]];
			[[listOfWebViews objectForKey:viewName] setOpaque:NO];
			if ([viewName isEqual:@"Your Mentor"]) {
				//[mentor setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[[[[profileContent objectAtIndex:0] objectAtIndex:1] objectAtIndex:i] objectAtIndex:2] objectForKey:@"character"] ofType:@"png"]]];
			}
		}
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void) onClose:(id) sender {
	[[ShellViewController getInstance] addSwipeGastures];
	[[self.view superview] removeFromSuperview];
	[[self.view superview] release];
	[self release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
	[yourProfile release];
	[yourCustomer release];
	[yourMentor release];
	[yourRole release];
	[yourDescription release];
	[customerDescription release];
	[mentorDescription release];
	[roleDescription release];
	[mentor release];
	//[listOfViews release];
	//[listOfWebViews release];
    [super dealloc];
}


@end
