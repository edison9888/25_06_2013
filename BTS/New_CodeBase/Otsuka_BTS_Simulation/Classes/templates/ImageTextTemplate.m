    //
//  ImageTextTemplate.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageTextTemplate.h"
#import "ShellViewController.h"

@implementation ImageTextTemplate

@synthesize pageContent;
@synthesize continueBtn, descriptionText, character, instructionalText, instructionalIcon;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void) initActivity {
	pageContent = [[NSArray arrayWithArray:[[ShellViewController getInstance] getPageContent]] retain];
	[descriptionText loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:2] objectForKey:@"descriptionText"] baseURL:[NSURL URLWithString:@""]];
	// To disable overscrolling
	UIScrollView *scrollView = nil;
	for(UIView *aView in descriptionText.subviews){
		if([aView isKindOfClass:[UIScrollView class] ]){
			scrollView = (UIScrollView *)aView;
			scrollView.delegate = self;
			scrollView.bounces = NO;
			[self performSelector:@selector(flashTableScrollIndicatorsForText:) withObject:scrollView afterDelay:1.0];
		}
	}
	
	// To remove black background while scrolling
	descriptionText.backgroundColor = [UIColor clearColor];
	descriptionText.opaque = NO;
	
	[character setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[[pageContent objectAtIndex:0] objectAtIndex:3] objectForKey:@"character"] ofType:@"png"]]];
    
    [instructionalText setUserInteractionEnabled:NO];
	instructionalText.backgroundColor = [UIColor clearColor];
	instructionalText.opaque = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue] > webView.frame.size.height) {
        instructionalText.hidden = NO;
        [instructionalText loadHTMLString:[ShellViewController getScrollDownInstructionalText] baseURL:[NSURL URLWithString:@""]];
        instructionalIcon.hidden = NO;
    }
}

- (void) flashTableScrollIndicatorsForText:(UIScrollView *) scrollVw {
	[scrollVw flashScrollIndicators];
	[self performSelector:@selector(flashTableScrollIndicatorsForText:) withObject:scrollVw afterDelay:2.0];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (IBAction) onContinue:(id) sender {
	[self nextPage];
}

- (void) nextPage {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[[ShellViewController getInstance] loadPageById:[[[pageContent objectAtIndex:0] objectAtIndex:5] objectForKey:@"branchTo"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
    
	[pageContent release];
	[continueBtn release];
	[descriptionText release];
	[character release];
    [instructionalText release];
    [instructionalIcon release];
    [super dealloc];
}

@end
