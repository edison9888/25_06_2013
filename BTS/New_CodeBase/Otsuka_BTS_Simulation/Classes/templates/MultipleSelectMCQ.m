    //
//  MultipleSelectMCQ.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//Edited Aug 17
#import "MultipleSelectMCQ.h"
#import "ShellViewController.h"

@interface MultipleSelectMCQ ()

- (void) choiceSelected:(UIButton *) sender;

@end


@implementation MultipleSelectMCQ

// Params for progress bars
static const float DEFAULT_X_POS_CHOICE = 150.0;
static const float DEFAULT_Y_POS_CHOICE = 235.0;
static const float DEFAULT_WIDTH_CHOICE = 32.0;
static const float DEFAULT_HEIGHT_CHOICE = 32.0;
static const float DEFAULT_X_POS_CHOICE_WITH_SPLIT = 520.0;

static const float DEFAULT_WIDTH_CHOICE_TEXT = 700.0;
static const float DEFAULT_HEIGHT_CHOICE_TEXT = 55.0;
static const float DEFAULT_WIDTH_CHOICE_TEXT_WITH_SPLIT = 350.0;

static const int SPLIT_CHOICE_AFTER = 7;

static const float Y_DIFF_CHOICE = 22;

// Params for KPI Labels
static const float DEFAULT_WIDTH_LINE = 755.0;
static const float DEFAULT_HEIGHT_LINE = 0.0;
static const float X_DIFF_LINE = 2;
static const float Y_DIFF_LINE = 3;

static const float DEFAULT_WIDTH_LINE_WITH_SPLIT = 375.0;

@synthesize pageContent, options;
@synthesize titleText, questionText, decideBtn, correctAnsArray, choiceSeldata;

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
	
	decideBtn.enabled = NO;
	options = [[NSMutableDictionary alloc] init];
	choiceSeldata = [[NSMutableDictionary alloc] init];
    correctAnsArray = [[NSMutableDictionary alloc] init];
	pageContent = [[NSArray arrayWithArray:[[ShellViewController getInstance] getPageContent]] retain];
	//titleText.text = [[[pageContent objectAtIndex:0] objectAtIndex:1] objectForKey:@"title"];
	[questionText loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:3] objectForKey:@"instructions"] baseURL:[NSURL URLWithString:@""]];
	[titleText loadHTMLString:[[[pageContent objectAtIndex:0] objectAtIndex:1] objectForKey:@"title"] baseURL:[NSURL URLWithString:@""]];
	
	// To disable overscrolling
	UIScrollView *scrollView = nil;
	for(UIView *aView in questionText.subviews){
		if([aView isKindOfClass:[UIScrollView class] ]){
			scrollView = (UIScrollView *)aView;
			//scrollView.scrollEnabled = NO;
			scrollView.bounces = NO;
		}
	}
	// To remove black background while scrolling
	questionText.backgroundColor = [UIColor clearColor];
	questionText.opaque = NO;
	
	int choiceCount = [[[pageContent objectAtIndex:0] objectAtIndex:4] count];
    float choiceX = DEFAULT_X_POS_CHOICE;
    float choiceY = DEFAULT_Y_POS_CHOICE;
    float choiceTextWidth = (choiceCount > SPLIT_CHOICE_AFTER) ? DEFAULT_WIDTH_CHOICE_TEXT_WITH_SPLIT : DEFAULT_WIDTH_CHOICE_TEXT;
	for (int i = 0; i<choiceCount; i++) {
        int i_split = i;
        if (i >= SPLIT_CHOICE_AFTER) {
            choiceX = DEFAULT_X_POS_CHOICE_WITH_SPLIT;
            i_split = (i - SPLIT_CHOICE_AFTER);
        }
		UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		choiceBtn.frame = CGRectMake(choiceX, choiceY + ((DEFAULT_HEIGHT_CHOICE + Y_DIFF_CHOICE) * (float)i_split), DEFAULT_WIDTH_CHOICE, DEFAULT_HEIGHT_CHOICE);
		choiceBtn.tag = (i + 1);
		[choiceBtn addTarget:self action:@selector(choiceSelected:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
		[choiceBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"option" ofType:@"png"]] forState:UIControlStateNormal];
		[choiceBtn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"option_selected" ofType:@"png"]] forState:UIControlStateSelected];
		[options setObject:choiceBtn forKey:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"]];
		[self.view addSubview:choiceBtn];
		
		UIWebView *choiceText = [[UIWebView alloc] initWithFrame:CGRectMake(choiceX+30, DEFAULT_Y_POS_CHOICE + ((DEFAULT_HEIGHT_CHOICE + Y_DIFF_CHOICE) * (float)i_split) - 8, choiceTextWidth, DEFAULT_HEIGHT_CHOICE_TEXT)];
		[choiceText loadHTMLString:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:i] objectAtIndex:2] objectForKey:@"choiceText"] baseURL:[NSURL URLWithString:@""]];
		choiceText.backgroundColor = [UIColor clearColor];
		choiceText.opaque = NO;
		choiceText.userInteractionEnabled = NO;
		[self.view addSubview:choiceText];
		[choiceText release];
		
		
		UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"line02" ofType:@"png"]]];
		line.frame = CGRectMake(choiceBtn.frame.origin.x - X_DIFF_LINE, choiceBtn.frame.origin.y + choiceBtn.frame.size.height + Y_DIFF_LINE, DEFAULT_WIDTH_LINE, DEFAULT_HEIGHT_LINE);
		[self.view addSubview:line];
		
		[line release];		
		[choiceBtn release];
		
		//NSLog(@"isCorrect >>> %@", [[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:j] objectAtIndex:1] objectForKey:@"isCorrect"]);
		
		if ([[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:i] objectAtIndex:1] objectForKey:@"isCorrect"] isEqual:@"YES"]) {
			[correctAnsArray setValue:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"] forKey:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:i] objectAtIndex:0] objectForKey:@"id"]];
		}
	}
	
	
}

- (void) choiceSelected:(UIButton *) sender {
    sender.selected = !sender.selected;
    
    decideBtn.enabled = NO;
    for (NSString *i in options) {
        UIButton *temp = [options objectForKey:i];
        if (temp.selected) {
            decideBtn.enabled = YES;
            break;
        }
    }
    
    if (sender.selected) {
        [choiceSeldata setValue:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:(sender.tag - 1)] objectAtIndex:0] objectForKey:@"id"] forKey:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:(sender.tag - 1)] objectAtIndex:0] objectForKey:@"id"]];
    } else {
        [choiceSeldata removeObjectForKey:[[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:(sender.tag - 1)] objectAtIndex:0] objectForKey:@"id"]];
    }
}

- (IBAction) onDecide:(id) sender {
    int totalSelected = 0;

    for (NSString *i in options) {
        UIButton *temp = [options objectForKey:i];
        if (temp.selected) {
            totalSelected++;
        }
    }
    
    if (totalSelected != [correctAnsArray count]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
                                                            message:[NSString stringWithFormat:@"Please choose %d of the available options", [correctAnsArray count]]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    decideBtn.enabled = NO;
    
    int totalCorrect = 0;
    if ([choiceSeldata isEqualToDictionary:correctAnsArray]) {
        totalCorrect = [choiceSeldata count];
    } else {
        for (NSString *i in choiceSeldata) {
            if ([[choiceSeldata objectForKey:i] isEqual:[correctAnsArray objectForKey:i]]) {
                totalCorrect++;
            }
        }
    }
    
	//if(totalCorrect == [correctAnsArray count] && totalCorrect == [choiceSeldata count])
    if(totalCorrect >= [correctAnsArray count])
	{
		NSLog(@"Allcorrect");
		setvalidationval=2;
	} /*else if(totalCorrect > 1) {
        NSLog(@"more than 1 correct");
        setvalidationval=1;*/
    else if(totalCorrect == [correctAnsArray count]-1)
    {
        setvalidationval=1;
        
        
    } else {
		NSLog(@"1 or less correct");
		setvalidationval=0;
	}
	
	//*******************************************Start******************************************************************
	
	int validationlen = [[[pageContent objectAtIndex:0] objectAtIndex:5] count];

	NSMutableDictionary *kpiData = [[[NSMutableDictionary alloc] init] autorelease];
	
	for(int x = 1; x<=validationlen; x++)
	{
        NSArray *kpi = [NSArray arrayWithArray:[[[[pageContent objectAtIndex:0] objectAtIndex:5] objectAtIndex:(x-1)] objectAtIndex:0]];
        for (int j = 1; j < [kpi count]; j++) {
		//NSLog(@"kpiData >>> %@", [[kpi objectAtIndex:j] objectForKey:@"KPI"]);
            [kpiData setObject:[[[kpi objectAtIndex:j] objectForKey:@"attributes"] objectForKey:@"marks"] forKey:[NSString stringWithFormat:@"Max %@",[[kpi objectAtIndex:j] objectForKey:@"KPI"]]];
        }
	}
				
	NSArray *kpi = [NSArray arrayWithArray:[[[[pageContent objectAtIndex:0] objectAtIndex:5] objectAtIndex:setvalidationval] objectAtIndex:0]];
    for (int k = 1; k < [kpi count]; k++) {
        [kpiData setObject:[[[kpi objectAtIndex:k] objectForKey:@"attributes"] objectForKey:@"marks"] forKey:[[kpi objectAtIndex:k] objectForKey:@"KPI"]];
    }
	
    NSLog(@"KPIDATA >>> %@", kpiData);
    	
    NSMutableString *correctChoices = [NSMutableString stringWithString:@""];
    for (NSString *l in correctAnsArray) {
        [correctChoices appendFormat:@"%@,", [correctAnsArray objectForKey:l]];
    }
    [correctChoices deleteCharactersInRange:NSMakeRange([correctChoices length]-1, 1)];
	
    NSMutableString *selectedChoices = [NSMutableString stringWithString:@""];
    for (NSString *l in choiceSeldata) {
        [selectedChoices appendFormat:@"%@,", [choiceSeldata objectForKey:l]];
    }
    [selectedChoices deleteCharactersInRange:NSMakeRange([selectedChoices length]-1, 1)];
	
	NSMutableDictionary *decisionData = [NSMutableDictionary dictionaryWithObjectsAndKeys:selectedChoices, @"ChoiceSelected", correctChoices, @"CorrectChoice", nil];
    for (NSString *kpi in kpiData) {
        if (![[[kpi substringToIndex:4] lowercaseString] isEqualToString:@"max "]) {
            [decisionData setValue:[kpiData objectForKey:kpi] forKey:kpi];
        }
    }
	//NSLog(@"correctChoices >>>> %@", correctChoices);
	[ShellViewController saveDecisionData:decisionData forID:[[[pageContent objectAtIndex:0] objectAtIndex:0] objectForKey:@"id"]];
	[ShellViewController updateKPIs:kpiData];
	//NSLog(@"branchTo = %@", [[[[[pageContent objectAtIndex:0] objectAtIndex:4] objectAtIndex:(i-1)] objectAtIndex:4] objectForKey:@"branchTo"]);
	
	[[ShellViewController getInstance] loadPageById:[[[[[pageContent objectAtIndex:0] objectAtIndex:5] objectAtIndex:setvalidationval] objectAtIndex:1] objectForKey:@"branchTo"]];
}


- (void) nextPage {
	// Left empty to avoid going to next page through swipe gesture.
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
	[questionText release];
	[decideBtn release];
    [super dealloc];
}


@end
