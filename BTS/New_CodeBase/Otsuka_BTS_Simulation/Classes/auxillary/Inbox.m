    //
//  Inbox.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//AUG 09 2011
#import "Inbox.h"
#import "ShellViewController.h"

@interface Inbox ()

- (void) formatWebView:(UIWebView *) webVw;
- (void) flashTableScrollIndicatorsForText:(UIScrollView *) scrollVw;

@end

@implementation Inbox

@synthesize pageContent;
@synthesize titleText, fromText, toText, emailContent, character, emailTypeImage, emailType, instructionalText, instructionalIcon;

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
	[self initActivity];
	[self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
    [super viewDidLoad];
}


- (void) initActivity {
	pageContent = [[NSArray arrayWithArray:[[ShellViewController getInstance] getPageContent]] retain];
    
    [titleText loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:3] objectForKey:@"title"] baseURL:[NSURL URLWithString:@""]];
    [self formatWebView:titleText];
    
    /*[fromText loadHTMLString:[NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>From: %@%@", [[[pageContent objectAtIndex:0] objectAtIndex:5] objectForKey:@"from"], @"</welcomeText>"] baseURL:[NSURL URLWithString:@""]];
    [self formatWebView:fromText];*/
    
    [emailType loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:1] objectForKey:@"emailHeader"] baseURL:[NSURL URLWithString:@""]];
    [self formatWebView:emailType];
    
    NSMutableDictionary *userData = [ShellViewController getUserData];
   if([[[[pageContent objectAtIndex:0] objectAtIndex:8] objectForKey:@"to"] isEqualToString:@"You"])
    {
       
        
       [fromText loadHTMLString:[NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>From: %@%@", [[[pageContent objectAtIndex:0] objectAtIndex:5] objectForKey:@"from"], @"</welcomeText>"] baseURL:[NSURL URLWithString:@""]];
        [self formatWebView:fromText];
        
        
        NSString *toName = [NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>To: %@ %@%@", [userData objectForKey:@"firstName"], [userData objectForKey:@"lastName"], @"</welcomeText>"];
        [toText loadHTMLString:toName baseURL:[NSURL URLWithString:@""]];
        [self formatWebView:toText];
        
        
        NSString *toContent = [NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>%@ %@ %@ %@ %@ %@", [[[pageContent objectAtIndex:0] objectAtIndex:4] objectForKey:@"emailContent"],[[[pageContent objectAtIndex:0] objectAtIndex:9] objectForKey:@"previousemailContent"],@"</welcomeText>",@"<IndentText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-indent:10px; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'><br><span style='margin:0 0 0 10px;'>Best Regards,</span><br><span style='margin:0 0 0 10px;'>",[userData objectForKey:@"firstName"], [userData objectForKey:@"lastName"],@"</span></IndentText>"];
        [emailContent loadHTMLString:toContent baseURL:[NSURL URLWithString:@""]];
        [self formatWebView:emailContent];
        [emailContent setUserInteractionEnabled:YES];
        
      
        
               
    }
    
    
    else
    {
        [fromText loadHTMLString:[NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>From: %@%@", [[[pageContent objectAtIndex:0] objectAtIndex:5] objectForKey:@"from"], @"</welcomeText>"] baseURL:[NSURL URLWithString:@""]];
        [self formatWebView:fromText];
        
        
    NSString *toName = [NSString stringWithFormat:@"<welcomeText style=' font-family:Helvetica; font-size:12pt; line-height:18pt; text-align:justify; font-weight:normal; color:#333; display:block; margin:0 10px 10px'>To: %@ %@%@", [userData objectForKey:@"firstName"], [userData objectForKey:@"lastName"], @"</welcomeText>"];
    [toText loadHTMLString:toName baseURL:[NSURL URLWithString:@""]];
    [self formatWebView:toText];
        
   
        [emailContent loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:4] objectForKey:@"emailContent"] baseURL:[NSURL URLWithString:@""]];
        [self formatWebView:emailContent];
        [emailContent setUserInteractionEnabled:YES];
        
        
    
       }

    /*[emailContent loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:4] objectForKey:@"emailContent"] baseURL:[NSURL URLWithString:@""]];
    [self formatWebView:emailContent];
    [emailContent setUserInteractionEnabled:YES];*/
    
	// To disable overscrolling
	UIScrollView *scrollView = nil;
	for(UIView *aView in emailContent.subviews){
		if([aView isKindOfClass:[UIScrollView class] ]){
			scrollView = (UIScrollView *)aView;
			scrollView.delegate = self;
			scrollView.bounces = NO;
			[self performSelector:@selector(flashTableScrollIndicatorsForText:) withObject:scrollView afterDelay:1.0];
		}
	}
		
	[character setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[[pageContent objectAtIndex:0] objectAtIndex:6] objectForKey:@"character"] ofType:@"png"]]];
    
	[emailTypeImage setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[[pageContent objectAtIndex:0] objectAtIndex:2] objectForKey:@"emailTypeImage"] ofType:@"png"]]];

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

- (void) formatWebView:(UIWebView *) webVw {
	// To remove black background while scrolling
	webVw.backgroundColor = [UIColor clearColor];
	webVw.opaque = NO;
    [webVw setUserInteractionEnabled:NO];
}

- (IBAction) onClose:(UIButton *) sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	[[ShellViewController getInstance] addSwipeGastures];
    [[ShellViewController getInstance] enable:NO Btn:@"inbox"];
    [[ShellViewController getInstance] loadPageById:[[[pageContent objectAtIndex:0] objectAtIndex:7] objectForKey:@"branchTo"]];
	[self.view removeFromSuperview];
	[self release];
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
    [titleText release];
    [fromText release];
    [toText release];
    [emailContent release];
    [character release];
    [emailTypeImage release];
    [emailType release];
    [instructionalText release];
    [instructionalIcon release];
    [super dealloc];
}


@end