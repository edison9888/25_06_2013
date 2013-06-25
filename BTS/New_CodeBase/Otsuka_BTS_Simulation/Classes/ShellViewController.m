//
//  ShellViewController.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ShellViewController.h"
#import "Config.h"
#import "UserData.h"
#import "XmlParser.h"
#import "PostData.h"

// Aux
#import "Profile.h"
#import "Inbox.h"
#import "Metrics.h"
#import "Resources.h"
#import "Feedback.h"
#import "ProfilePopOverController.h"

// Templates
#import "LoginView.h"
#import "ImageTextTemplate.h"
#import "SingleSelectMCQ.h"
#import "MultipleSelectMCQ.h"
#import "TextOnlyTemplate.h"
#import "InboxTemplate.h"

@interface ShellViewController()

- (void) removeAllViews;
- (void) changeBackground:(NSString *) imageName;
- (void) animateFadingIn:(UIView *)vw;
- (void) animateView:(UIView *) newView;
- (void) showModalView:(UIViewController *) modalVC;
- (void) removeModalView:(UIViewController *) modalVC;
- (void) setShellVariables;
- (void) setRoundVariables;
- (int) getCurrentRoundPointer;
- (void) loadLoginScreen;
- (void) saveBookMark:(NSString *) bookMark;
- (void) removeSwipeGestures;
- (void) setInitialAuxButtonsState;
- (void) storeAuxButtonsState;

+ (void) sendDataToServerForRound:(int) roundNum;

@end


@implementation ShellViewController

@synthesize templateObjects, currentTemplate, defaultImageExtn, currentRoundStructure, pagesInfo, currentRoundInfo, currentRoundTitle, currentPageContent;
@synthesize templateView, progressBar, progressPercent, bgnd, profilePopover, recognizer;
@synthesize profileBtn, inboxBtn, metricsBtn, resourcesBtn, feedbackBtn;

static ShellViewController *_instance;

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

+ (ShellViewController *) getInstance {
	return _instance;
}

+ (int) getTotalRounds {
	return [Config getTotalRounds];
}

+ (int) getCurrentRound {
	return [[ShellViewController getInstance] getCurrentRoundPointer];
}

+ (NSArray *) getCurrentRoundKPIs {
	return [ShellViewController getKPIsForRound:[[ShellViewController getInstance] getCurrentRoundPointer]];
}

+ (NSArray *) getCurrentRoundMaxKPIs {
	return [ShellViewController getMaxKPIsForRound:[[ShellViewController getInstance] getCurrentRoundPointer]];
}

+ (NSArray *) getKPIsForRound:(int) roundNum {
	return [[Config getInstance] getKPIsForRound:roundNum];
}

+ (NSArray *) getMaxKPIsForRound:(int) roundNum {
	return [[Config getInstance] getMaxKPIsForRound:roundNum];
}

+ (NSString *) getNameForRound:(int) roundNum {
	return [[Config getInstance] getNameForRound:roundNum];
}

+ (NSString *) getEmailText {
	return [[Config getInstance] getEmailText];
}

+ (NSString *) getVoicemailText {
	return [[Config getInstance] getVoicemailText];
}

+ (NSString *) getScrollDownInstructionalText {
	return [[Config getInstance] getScrollDownInstructionalText];
}

+ (void) writeUserData:(NSMutableDictionary *) newUserData {
	if (newUserData != nil) {
		[[UserData getInstance] writeUserData:newUserData];
	}
}

+ (void) setAttemptComplete {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *attemptsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]]
                                         objectAtIndex:0];
    NSDate *end = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
	[attemptsData setObject:@"YES" forKey:@"FinishedAttempt"];
	[attemptsData setObject:@"Completed" forKey:@"Status"];
    [attemptsData setObject:[fm stringFromDate:end] forKey:@"EndDate"];
    [fm release];
	[ShellViewController writeUserData:userData];
    [ShellViewController sendDataToServerForRound:[ShellViewController getCurrentRound]];
}

+ (void) saveDecisionData:(NSMutableDictionary *) decisionData forID:(NSString *) pageID {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *roundsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]]
                                    objectAtIndex:0];
	[roundsData setObject:decisionData forKey:pageID];
	[ShellViewController writeUserData:userData];
}

+ (void) updateKPIs:(NSMutableDictionary *) kpi {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *roundsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]]
                                       objectAtIndex:0];
	int totalScore = 0;
	for (NSString *i in kpi) {
		int kpiValue = [[[roundsData objectForKey:@"KPIData"] objectForKey:i] intValue] + [[kpi objectForKey:i] intValue];
		[[roundsData objectForKey:@"KPIData"] setObject:[NSString stringWithFormat:@"%d", kpiValue] forKey:i];
		
		NSRange textRange = [i rangeOfString:@"Max "];
		if(textRange.location == NSNotFound)
		{
			totalScore += kpiValue;
		}
	}
    [roundsData setObject:[NSString stringWithFormat:@"%d", totalScore] forKey:@"TotalScore"];
	[ShellViewController writeUserData:userData];
    [[ShellViewController getInstance] highlight:YES Btn:@"metrics"];
}

+ (void) sendDataToServerForRound:(int) roundNum {
	[[PostData getInstance] sendDataToServerForRound:roundNum];
}

+ (NSMutableDictionary *) getUserData {
	return [[UserData getInstance] getUserData];
}

+ (BOOL) userDataExists {
	return [UserData userDataExists];
}

+ (BOOL) createNewUserData {
	return [UserData createNewUserData];
}

+ (BOOL) removeUserDataPlist {
    return [UserData removeUserDataPlist];
}

- (void) initActivity {
	_instance = self;
	[[Config getInstance] loadConfigFile];
	templateObjects = [[NSMutableArray alloc] init];
	[self setShellVariables];
	[self loadLoginScreen];	
}

- (void) loadLoginScreen {
	LoginView *login = [[LoginView alloc] init];
	[templateObjects addObject:login];
	[self.view addSubview:login.view];
    [login release];
}

- (void) setShellVariables {
	defaultImageExtn = [NSString stringWithString:[[[Config getInstance] getConfig] objectForKey:@"defaultImageExtn"]];
	NSString *imageName = [[[[[Config getInstance] getConfig] objectForKey:@"shellImages"] objectForKey:@"defaultBgnd"] retain];
	[self changeBackground:imageName];
	[imageName release];
	
	recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.direction =  UISwipeGestureRecognizerDirectionLeft;
	recognizer.delegate = self;
}

- (void) loadRound:(int) roundNum withBookmark:(NSString *) bookmark andPageCount:(int) pageCnt {
	currentRoundPointer = roundNum;
	pagePointer = -1;
	pageCount = pageCnt;
	totalPages = 0;
    [self setInitialAuxButtonsState];
	[self setRoundVariables];
	[self loadPageById:bookmark];
    
	[self addSwipeGastures];
    
    NSArray *attemptsData = [[[ShellViewController getUserData] objectForKey:@"Rounds"] objectAtIndex:roundNum];
    if ([attemptsData count] >1) {
        if ([[[attemptsData objectAtIndex:1] objectForKey:@"DataPosted"] isEqualToString:@"NO"]) {
            [ShellViewController sendDataToServerForRound:roundNum];
        }
    }
}

- (void) setInitialAuxButtonsState {
	NSMutableDictionary *roundsData = [[[[ShellViewController getUserData] objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]] objectAtIndex:0];
    BOOL state = ([[roundsData objectForKey:@"isFeedbackHighlighted"] isEqualToString:@"YES"])?YES:NO;
    [self highlight:state Btn:@"feedback"];
    [self enable:state Btn:@"feedback"];
    state = ([[roundsData objectForKey:@"isInboxHighlighted"] isEqualToString:@"YES"])?YES:NO;
    [self highlight:state Btn:@"inbox"];
    [self enable:state Btn:@"inbox"];
    state = ([[roundsData objectForKey:@"isMetricsHighlighted"] isEqualToString:@"YES"])?YES:NO;
    [self highlight:state Btn:@"metrics"];
}

- (void) setRoundVariables {
	currentRoundStructure = [[NSMutableArray alloc] init];
	pagesInfo = [[NSMutableDictionary alloc] init];
	//NSLog(@"currentRoundPointer >>> %d", currentRoundPointer);
	
	currentRoundInfo = [NSDictionary dictionaryWithDictionary:[[[[Config getInstance] getConfig] objectForKey:@"rounds"] objectAtIndex:currentRoundPointer]];
	//NSLog(@"currentRoundInfo >>> %@", currentRoundInfo);
	
	XmlParser *inst = [[XmlParser alloc] init];
	NSMutableArray *temp = [[inst loadXMLByURL:[currentRoundInfo objectForKey:@"mainXML"]] retain];
	[inst release];
	//NSLog(@"temp >>> %@", temp);
	
	currentRoundTitle = [NSString stringWithString:[[[temp objectAtIndex:0] objectAtIndex:0] objectForKey:@"title"]];
	//NSLog(@"currentRoundTitle >>> %@", currentRoundTitle);
	for(int i = 1; i<[[temp objectAtIndex:0] count]; i++) {
		for (int j = 0; j<[[[temp objectAtIndex:0] objectAtIndex:i] count]; j++) {
			if(j == 0) {
				totalPages += [[[[[[temp objectAtIndex:0] objectAtIndex:i] objectAtIndex:0] objectForKey:@"attributes"] objectForKey:@"totalPages"] intValue];
			} else {
				[currentRoundStructure addObject:[[[temp objectAtIndex:0] objectAtIndex:i] objectAtIndex:j]];
				[pagesInfo setObject:[NSNumber numberWithFloat:[currentRoundStructure count]-1] forKey:[[[[temp objectAtIndex:0] objectAtIndex:i] objectAtIndex:j] objectForKey:@"page"]];
			}
		}
	}
	//NSLog(@"pagesInfo >>> %@", pagesInfo);
	//NSLog(@"currentRoundStructure >>> %@", currentRoundStructure);
	[temp release];
	//NSLog(@"retainCount %d", [[currentRoundStructure objectAtIndex:1] retainCount]);
}

- (void) loadPageById:(NSString *) pageID {
	//[self removeAllViews];		
    [[[templateObjects objectAtIndex:0] view] removeFromSuperview];
    [templateObjects removeObjectAtIndex:0];
    //NSLog(@"templateObjects2 >>> %@", templateObjects);
	
	if ([pageID isEqual:@""] || pageID == NULL) {
		pagePointer++;
	} else {
		pagePointer = [[pagesInfo objectForKey:pageID] intValue];
	}
	
	NSString *xmlName = [[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"page"] retain];
	
	[currentPageContent release];
	XmlParser *inst = [[XmlParser alloc] init];
	currentPageContent = [[inst loadXMLByURL:xmlName] retain];
	[self saveBookMark:xmlName];
	[xmlName release];
	[inst release];	
	
	currentTemplate = [NSString stringWithString:[[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"template"]];
    //[[templateObjects objectAtIndex:0] release];
    //NSLog(@"templateObjects1 >>> %@", [[templateObjects objectAtIndex:[templateObjects count] - 1] class]);
	//[templateObjects removeObjectAtIndex:[templateObjects count] - 1];
    //NSLog(@"templateObjects2 >>> %d", [[templateObjects objectAtIndex:0] retainCount]);

	if ([currentTemplate isEqual:@"ImageTextTemplate"]) {
		ImageTextTemplate *iTInstance = [[ImageTextTemplate alloc] initWithNibName:@"ImageTextTemplate" bundle:nil];
		[templateObjects addObject:iTInstance];
		[iTInstance release];
	} else if ([currentTemplate isEqual:@"SingleSelectMCQ"]) {
		SingleSelectMCQ *sSMCQInstance = [[SingleSelectMCQ alloc] initWithNibName:@"SingleSelectMCQ" bundle:nil];
		[templateObjects addObject:sSMCQInstance];
		[sSMCQInstance release];
	} else if ([currentTemplate isEqual:@"MultipleSelectMCQ"]) {
		MultipleSelectMCQ *sMMCQInstance = [[MultipleSelectMCQ alloc] initWithNibName:@"MultipleSelectMCQ" bundle:nil];
		[templateObjects addObject:sMMCQInstance];
		[sMMCQInstance release];
	} else if ([currentTemplate isEqual:@"InboxTemplate"]) {
		InboxTemplate *sIInstance = [[InboxTemplate alloc] initWithNibName:@"InboxTemplate" bundle:nil];
		[templateObjects addObject:sIInstance];
		[sIInstance release];
        [self highlight:YES Btn:@"inbox"];
	} else if ([currentTemplate isEqual:@"TextOnlyTemplate"]) {
		TextOnlyTemplate *tOInstance = [[TextOnlyTemplate alloc] initWithNibName:@"TextOnlyTemplate" bundle:nil];
		[templateObjects addObject:tOInstance];
		[tOInstance release];
	}

	[[[templateObjects objectAtIndex:[templateObjects count] - 1] view] setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]];
	// Set Background Image for the page.
	if ([[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"bgnd"] != nil) {
		NSString *imageName = [[[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"bgnd"] retain];
		if (![imageName isEqual:@""])[self changeBackground:imageName];
		[imageName release];
	}
    if ([[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"increasePageCountBy"] != nil) {
        pageCount = pageCount + [[[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"increasePageCountBy"] intValue];
        //NSLog(@"pageCount >>> %d", [[[[currentRoundStructure objectAtIndex:pagePointer] objectForKey:@"attributes"] objectForKey:@"increasePageCountBy"] intValue]);
    } else {
        pageCount = pageCount + 1;        
        //NSLog(@"pageCount >>> 1");
    }
	progressBar.progress = (float)pageCount/(float)totalPages;
	progressPercent.text = [NSString stringWithFormat:@"%d%@", (int)(progressBar.progress * 100), @"%"];
	
	//NSLog(@"pageCount >>> %d, totalPages >>> %d", pageCount, totalPages);
	if (pageCount >= totalPages) {
		[self highlight:YES Btn:@"feedback"];
		[ShellViewController setAttemptComplete];
		[self removeSwipeGestures];
	}
	[self animateView:[[templateObjects objectAtIndex:[templateObjects count] - 1] view]];
    [self storeAuxButtonsState];
}

- (void) storeAuxButtonsState {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *roundsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]]
                                       objectAtIndex:0];
    NSString *state = (inboxBtn.highlighted)?@"YES":@"NO";
    [roundsData setValue:state forKey:@"isInboxHighlighted"];
    state = (feedbackBtn.highlighted)?@"YES":@"NO";
    [roundsData setValue:state forKey:@"isFeedbackHighlighted"];
    state = (metricsBtn.highlighted)?@"YES":@"NO";
    [roundsData setValue:state forKey:@"isMetricsHighlighted"];
    [ShellViewController writeUserData:userData];
}

- (void) removeAllViews {
	[[templateView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
}

- (void) changeBackground:(NSString *) imageName {
	[bgnd setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:defaultImageExtn]]];	
}

- (NSArray *) getPageContent {
	return currentPageContent;
}

- (int) getCurrentRoundPointer {
	return currentRoundPointer;
}

- (void) saveBookMark:(NSString *) bookMark {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *roundsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]]
                                       objectAtIndex:0];
    //NSLog(@"roundsData >>> %@", roundsData);
	[roundsData setObject:bookMark forKey:@"Bookmark"];
	[roundsData setObject:[NSNumber numberWithInt:pageCount] forKey:@"PageCount"];
	[ShellViewController writeUserData:userData];
}

- (void) animateFadingIn:(UIView *)vw {
	
 	//state before animation
	vw.alpha = 0.0;
	//vw.transform = CGAffineTransformMakeScale(2.00, 2.00);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationDelegate:self];
	
	//state after animation
	vw.alpha = 1.0;
	//vw.transform = CGAffineTransformMakeScale(1.00, 1.00);
	
	[UIView commitAnimations];
	
}

- (void) animateView:(UIView *) newView {
	
	// remove the current view and replace with myView1
	
	[self.templateView addSubview:newView];
	[self.templateView sendSubviewToBack:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	animation.duration = 0.5;
	animation.type = kCATransitionPush;
	//NSLog(@"clickedButtonStr>>>%@",clickedButtonStr);
	animation.subtype = kCATransitionFromRight;
	
	animation.delegate = self;
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self.templateView layer] addAnimation:animation forKey:@"SwitchToView1"];
	[[templateObjects objectAtIndex:[templateObjects count] - 1] initActivity];
}

- (void) removeSwipeGestures {
	[templateView removeGestureRecognizer:recognizer];
}

- (void) addSwipeGastures {
	[self removeSwipeGestures];
	[templateView addGestureRecognizer:recognizer];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

/*
 In response to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out.
 */
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *) recog {
	if (recog.direction == UISwipeGestureRecognizerDirectionLeft) {
		[[templateObjects objectAtIndex:[templateObjects count] - 1] nextPage];
    }
}

- (void) showModalView:(UIViewController *) modalVC {
	CATransition *animation = [CATransition animation];
	
	[animation setDelegate:self];
	[animation setType:kCATransitionMoveIn];
	[animation setSubtype:kCATransitionFromTop];
	
	[animation setDuration:0.50];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[modalVC.view layer] addAnimation:animation forKey:kCATransition];
	
	[self.view addSubview:modalVC.view];
	[modalVC viewDidAppear:YES];
}

- (void) removeModalView:(UIViewController *) modalVC {
	CATransition *animation = [CATransition animation];
	
	[animation setDelegate:self];
	[animation setType:kCATransitionReveal];
	[animation setSubtype:kCATransitionFromLeft];
	
	[animation setDuration:0.50];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[[modalVC.view superview] layer] addAnimation:animation forKey:kCATransition];
	
	[modalVC.view removeFromSuperview];
	[modalVC viewDidDisappear:YES];
	[modalVC release];
}


- (void) showProfileWithView:(NSString *) viewName {
	[self removeSwipeGestures];
	
	XmlParser *inst = [[XmlParser alloc] init];
	NSArray *profileContent = [[inst loadXMLByURL:@"ProfileInfo"] retain];
	[inst release];
	
	Profile *profileView = [[Profile alloc] initWithNibName:@"Profile" bundle:nil];
	//[self.view addSubview:profileView.view];
	UIView *profileLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
	profileLayer.backgroundColor = [UIColor clearColor];
	[profileLayer addSubview:profileView.view];
	[self.view addSubview:profileLayer];
	[profileView loadViewWithName:viewName andContent:profileContent];
	[profileContent release];
    
	if (profilePopover != nil) {
        [profilePopover dismissPopoverAnimated:YES];
    }        
}

- (void) highlight:(BOOL) highlight Btn:(NSString *) btnName {
    UIButton *btn;
    if ([btnName isEqualToString:@"inbox"]) {
        btn = inboxBtn;
    } else if ([btnName isEqualToString:@"feedback"]) {
        btn = feedbackBtn;
    } else if ([btnName isEqualToString:@"metrics"]) {
        btn = metricsBtn;
    }
    if (highlight == YES) [self enable:highlight Btn:btnName];
    btn.highlighted = highlight;
}

- (void) enable:(BOOL) enable Btn:(NSString *) btnName {
    UIButton *btn;
    if ([btnName isEqualToString:@"inbox"]) {
        btn = inboxBtn;
    } else if ([btnName isEqualToString:@"feedback"]) {
        btn = feedbackBtn;
    } else if ([btnName isEqualToString:@"metrics"]) {
        btn = metricsBtn;
    }
    btn.enabled = enable;
}


// IBActions
- (IBAction) onProfileClicked:(id) sender {
    if (self.profilePopover == nil) {
		//MoviesViewController
		//ProfilePopOverController
        ProfilePopOverController *list = [[ProfilePopOverController alloc] initWithNibName:@"ProfilePopOverController" bundle:[NSBundle mainBundle]]; 
		
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:list]; 
		
        popover.delegate = self;
        [list release];
		
        self.profilePopover = popover;
        [popover release];
    }
	
	CGRect popoverRect = CGRectMake(935, 172, 100, 100);
	
    [self.profilePopover presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction) onInboxClicked:(id) sender {
	Inbox *inboxView = [[Inbox alloc] initWithNibName:@"Inbox" bundle:nil];
	[self removeSwipeGestures];
	[self.view addSubview:inboxView.view];
    [self highlight:NO Btn:@"inbox"];
    [self storeAuxButtonsState];
}

- (IBAction) onMetricsClicked:(id) sender {
	Metrics *metricsView = [[Metrics alloc] initWithNibName:@"Metrics" bundle:nil];
	[self removeSwipeGestures];
    [metricsView initActivityWithRound:[self getCurrentRoundPointer]];
    [metricsView hideFeedbackBtn:[feedbackBtn isEnabled]];
	[self.view addSubview:metricsView.view];
    [self highlight:NO Btn:@"metrics"];
	[self storeAuxButtonsState];
}

- (IBAction) onResourcesClicked:(id) sender {
	
}

- (IBAction) onFeedbackClicked:(id) sender {
	Feedback  *feedbackView = [[Feedback alloc] initWithNibName:@"Feedback" bundle:nil];
	[self removeSwipeGestures];
	[feedbackView initActivityWithRound:[self getCurrentRoundPointer]];
	[self.view addSubview:feedbackView.view];
    [self highlight:NO Btn:@"feedback"];
    //[self highlight:YES Btn:@"metrics"];
    [self storeAuxButtonsState];
}

- (IBAction) onMainMenuClicked:(id) sender {
    [[[templateObjects objectAtIndex:0] view] removeFromSuperview];
    [templateObjects removeObjectAtIndex:0];
	LoginView *login = [[LoginView alloc] init];
	[templateObjects addObject:login];
    [login loadRoundsView];
    [self.view addSubview:login.view];
    [login release];
}

//---called when the user clicks outside the popover view---
- (BOOL) popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"popover about to be dismissed");
    return YES;
}

//---called when the popover view is dismissed---
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    NSLog(@"popover dismissed");    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) { return YES; } return NO;
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
    
	[templateObjects release];
	[currentRoundStructure release];
	[pagesInfo release];
	[currentPageContent release];
	
	[templateView release];
	[progressBar release];
	[progressPercent release];
	[bgnd release];
	[profileBtn release];
	[inboxBtn release];
	[metricsBtn release];
	[resourcesBtn release];
	[feedbackBtn release];
	[profilePopover release];
	[recognizer release];
	//[profileLayer release];
    [super dealloc];
}


@end
