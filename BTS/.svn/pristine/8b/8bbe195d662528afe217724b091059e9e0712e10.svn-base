    //
//  Metrics.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Metrics.h"
#import "ShellViewController.h"
#import "Feedback.h"

@implementation Metrics

// Params for progress bars
static const float DEFAULT_X_POS_PB = 180.0;
static const float DEFAULT_Y_POS_PB = 268.0;
static const float DEFAULT_WIDTH_PB = 664.0;
static const float DEFAULT_HEIGHT_PB = 80.0;
static const float Y_DIFF_PB = 67.0;

// Params for KPI Labels
static const float DEFAULT_X_POS_KPI = 174.5;
static const float DEFAULT_Y_POS_KPI = 210.0;
static const float DEFAULT_WIDTH_KPI = 660.0;
static const float DEFAULT_HEIGHT_KPI = 80.0;
static const float Y_DIFF_KPI = 67.0;

static const float DEFAULT_WIDTH_PB_BG = 674.0;
static const float DEFAULT_HEIGHT_PB_BG = 22.0;
static const float X_DIFF_PB_BG = 5.0;
static const float Y_DIFF_PB_BG = -5.0;


@synthesize totalScore, bgnd, feedbackBtn, feedbackLbl;

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
	[self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0]];
    [super viewDidLoad];
}

- (void) hideFeedbackBtn:(BOOL) stat {
    feedbackBtn.hidden = feedbackLbl.hidden = !stat;
}

- (void) initActivityWithRound:(int) currentRoundPointer {
	NSArray *KPIs = [ShellViewController getKPIsForRound:currentRoundPointer];
	NSDictionary *userData = [ShellViewController getUserData];
    currentRound = currentRoundPointer;
	//NSMutableArray *progressBars = [[NSMutableArray alloc] init];
	for (int i = 0; i<[KPIs count]; i++) {
		int KPIVal = [[[[[[userData objectForKey:@"Rounds"] objectAtIndex:currentRoundPointer] objectAtIndex:0] objectForKey:@"KPIData"] objectForKey:[KPIs objectAtIndex:i]] intValue];
        int KPIMax = [[[ShellViewController getMaxKPIsForRound:currentRoundPointer] objectAtIndex:i] intValue];
		//int KPIMax = [[[[[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]] objectAtIndex:0] objectForKey:@"KPIData"] objectForKey:[NSString stringWithFormat:@"Max %@", [KPIs objectAtIndex:i]]] intValue];
		//NSLog(@"KPIVal >>> %d, KPIMax %d", KPIVal, KPIMax);
        
		UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		progressView.frame = CGRectMake(DEFAULT_X_POS_PB, DEFAULT_Y_POS_PB + (Y_DIFF_PB * (float)i), DEFAULT_WIDTH_PB, DEFAULT_HEIGHT_PB);
		progressView.progress = (float)KPIVal/(float)KPIMax;
		[self.view addSubview:progressView];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(DEFAULT_X_POS_KPI, DEFAULT_Y_POS_KPI + (Y_DIFF_KPI * (float)i), DEFAULT_WIDTH_KPI, DEFAULT_HEIGHT_KPI)];

		label.text = [NSString stringWithFormat:@"%@ = %@", [KPIs objectAtIndex:i], [NSString stringWithFormat:@"%d%@", (int)(progressView.progress * 100), @"%"]];
		[label setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
		[self.view addSubview:label];
		[label release];
		
		UIImageView *progressViewBg = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mterics_bar_bg" ofType:@"png"]]];
		progressViewBg.frame = CGRectMake(progressView.frame.origin.x - X_DIFF_PB_BG, progressView.frame.origin.y - Y_DIFF_PB_BG, DEFAULT_WIDTH_PB_BG, DEFAULT_HEIGHT_PB_BG);
		[progressViewBg setContentMode:UIViewContentModeCenter];
		[self.view insertSubview:progressViewBg belowSubview:progressView];
		[progressViewBg release];
		[progressView release];
	}
	totalScore.text = [NSString stringWithFormat:@"%@", [[[[userData objectForKey:@"Rounds"] objectAtIndex:currentRoundPointer] objectAtIndex:0] objectForKey:@"TotalScore"]];
}

- (IBAction) onClose:(id) sender {
	//[[ShellViewController getInstance] removeModalView:self];
	[[ShellViewController getInstance] addSwipeGastures];
	[self.view removeFromSuperview];
	[self release];
}

- (IBAction) onFeedbackClicked:(id) sender {
	Feedback  *feedbackView = [[Feedback alloc] initWithNibName:@"Feedback" bundle:nil];
	[feedbackView initActivityWithRound:currentRound];
	[[self.view superview] addSubview:feedbackView.view];
    [self performSelector:@selector(onClose:)];
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
    
	[totalScore release];
    [feedbackBtn release];
    [feedbackLbl release];
	[bgnd release];
    [super dealloc];
}


@end
