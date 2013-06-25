//
//  InboxTemplate.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxTemplate.h"
#import "ShellViewController.h"

@implementation InboxTemplate

@synthesize inboxContents;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

*/

- (void) initActivity {
    NSString *inboxInstruction = @"";
    if ([[[[[[ShellViewController getInstance] getPageContent] objectAtIndex:0] objectAtIndex:2] objectForKey:@"emailTypeImage"] isEqualToString:@"mail"]) {
        inboxInstruction = [ShellViewController getEmailText];
    } else {
        inboxInstruction = [ShellViewController getVoicemailText];
    }
    [inboxContents loadHTMLString:inboxInstruction baseURL:[NSURL URLWithString:@""]];
	inboxContents.backgroundColor = [UIColor clearColor];
	inboxContents.opaque = NO;
    [inboxContents setUserInteractionEnabled:NO];
}

- (void) nextPage {
	// Left empty to avoid going to next page through swipe gesture.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) dealloc
{
    [inboxContents release];
    [super dealloc];
}

@end
