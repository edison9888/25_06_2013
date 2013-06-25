//
//  LoginView.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"
#import "ShellViewController.h"
#import "Feedback.h"

//Private variables and semi private methods
@interface LoginView()

- (void) populateRoundsView:(int) roundNum withObjects:(NSMutableDictionary *) objArr;
- (UIButton *) formatBtn:(UIButton *) btn withTitle:(NSString *) title andReference:(UIButton *) refBtn;
- (void) createNewUserData;
- (NSMutableArray *) createNewAttemptForRound:(int) roundNum;
- (void) exitApplication;

@end

@implementation LoginView

@synthesize firstName, lastName, roundsView, statusText, roundName;
@synthesize statusText2, roundName2, startNew2, resumeBtn2, feedbackBtn2;
@synthesize statusText4, roundName4, startNew4, resumeBtn4, feedbackBtn4;
@synthesize statusText5, roundName5, startNew5, resumeBtn5, feedbackBtn5;
@synthesize statusText3, roundName3, startNew3, resumeBtn3, feedbackBtn3;

@synthesize submit, startNew, resumeBtn, feedbackBtn;

static BOOL isNewUser;

// Params for round data
static const float Y_DIFF = 35;

// Params for KPI Labels
static const float Y_DIFF_LINE = 3;

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
    if ([ShellViewController userDataExists]) {
        NSMutableDictionary *userData = [ShellViewController getUserData];
        firstName.text = [userData objectForKey:@"firstName"];
        lastName.text = [userData objectForKey:@"lastName"];
    }
    [super viewDidLoad];
}

- (IBAction) onExitCourse:(id) sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to exit?"
                                                   delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
    alert.tag = 2;
    [alert release];
}

- (void) exitApplication {
    exit(0);
}

- (IBAction) onSubmit:(id) sender {
	if ([firstName.text isEqual:@""]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
															message:@"Please enter a first name"
														   delegate:self
												  cancelButtonTitle:@"OK" 
												  otherButtonTitles: nil];
		[alertView show];
		[alertView release];
		return;
	}
	
	if ([lastName.text isEqual:@""]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
															message:@"Please enter a last name"
														   delegate:self
												  cancelButtonTitle:@"OK" 
												  otherButtonTitles: nil];
		[alertView show];
		[alertView release];
		return;
	}
	
	NSMutableDictionary *userData = [ShellViewController getUserData];
	isNewUser = NO;
	if (![[firstName.text lowercaseString] isEqual:[[userData objectForKey:@"firstName"] lowercaseString]] || ![[lastName.text lowercaseString] isEqual:[[userData objectForKey:@"lastName"] lowercaseString]]) {
		if ([ShellViewController userDataExists]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Selecting Yes will delete the data of previous user."
													   delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
			[alert show];
            alert.tag = 1;
			[alert release];
		} else {
			if ([ShellViewController createNewUserData]) {			
				isNewUser = YES;
				[self createNewUserData];
				[self loadRoundsView];				
			} else {
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" 
																	message:@"Cannot Create User Database"
																   delegate:self
														  cancelButtonTitle:@"OK" 
														  otherButtonTitles: nil];
				[alertView show];
				[alertView release];
			}

		}
	} else {
		isNewUser = NO;
		[self loadRoundsView];
	}
}

- (void) createNewUserData {
    [ShellViewController removeUserDataPlist];
    [ShellViewController createNewUserData];
	NSMutableDictionary *newUserData = [NSMutableDictionary dictionaryWithObjectsAndKeys:[firstName.text capitalizedString], @"firstName", [lastName.text capitalizedString], @"lastName", nil];
	int totalRounds = [ShellViewController getTotalRounds];
	NSMutableArray *round = [[[NSMutableArray alloc] initWithCapacity:totalRounds] autorelease];
	for (int i = 0; i<totalRounds; i++) {
		[round addObject:[self createNewAttemptForRound:i]];
	}
	[newUserData setObject:round forKey:@"Rounds"];
	[ShellViewController writeUserData:newUserData];
}

- (NSMutableArray *) createNewAttemptForRound:(int) roundNum {
    NSMutableDictionary *userData = [ShellViewController getUserData];
    NSMutableArray *temp = [[userData objectForKey:@"Rounds"] objectAtIndex:roundNum];
    if (temp == NULL) {
        temp = [[[NSMutableArray alloc] init] autorelease];
    } else if ([[[temp objectAtIndex:0] objectForKey:@"Status"] isEqualToString:@"Not Started"]) {
        return temp;
    }
    NSArray *KPIs = [ShellViewController getKPIsForRound:roundNum];
    NSMutableDictionary *roundKPIs = [[[NSMutableDictionary alloc] initWithCapacity:[KPIs count]] autorelease];
    for (int j = 0; j < [KPIs count]; j++) {
        [roundKPIs setObject:[NSNumber numberWithInt:0] forKey:[KPIs objectAtIndex:j]];
        [roundKPIs setObject:[NSNumber numberWithInt:0] forKey:[NSString stringWithFormat:@"Max %@", [KPIs objectAtIndex:j]]];
    }
    NSString *newUUID = [NSString stringWithFormat:@"%@", CFUUIDCreateString(nil, CFUUIDCreate(nil))];
    NSDate *start = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDictionary *roundData = [NSDictionary dictionaryWithObjectsAndKeys:newUUID, @"AttemptID", roundKPIs, @"KPIData", 
                               @"NO", @"FinishedAttempt", @"Not Started", @"Status", @"", @"Bookmark", [NSNumber numberWithInt:0],
                               @"PageCount", [NSNumber numberWithInt:0], @"TotalScore", @"NO", @"isInboxHighlighted", @"NO", @"isMetricsHighlighted", @"NO", @"isFeedbackHighlighted", [NSString stringWithString:[fm stringFromDate:start]], @"StartDate", @"", @"EndDate", @"NO", @"DataPosted", nil];
    [fm release];
    [temp insertObject:roundData atIndex:0];
    return temp;
}

- (void) alertView : (UIAlertView *)alertView clickedButtonAtIndex : (NSInteger)buttonIndex {
	if(buttonIndex == 0)
	{
        if (alertView.tag == 1) {
            isNewUser = YES;
            [self createNewUserData];
            [self loadRoundsView];
        }
        if (alertView.tag == 2) {
            [self exitApplication];
        }
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{
    NSRange spaceRange = [string rangeOfString:@" "];
    if (spaceRange.location != NSNotFound)
    {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter first and last name (do not include spaces)" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [error show];
        return NO;
    } else {
        return YES;
    }
}

- (IBAction) onStartRound:(UIButton *) sender {
    NSMutableDictionary *userData = [ShellViewController getUserData];
    [[userData objectForKey:@"Rounds"] replaceObjectAtIndex:sender.tag withObject:[self createNewAttemptForRound:sender.tag]];
    [ShellViewController writeUserData:userData];
	[self onExit:sender.tag];
}

- (IBAction) onResumeRound:(UIButton *) sender {
	[self onExit:sender.tag];
}

- (IBAction) onFeedback:(UIButton *) sender {
	Feedback  *feedbackView = [[Feedback alloc] initWithNibName:@"Feedback" bundle:nil];
	[feedbackView initActivityWithRound:sender.tag];
    //feedbackView.view.frame = CGRectMake(60, feedbackView.view.frame.origin.y, feedbackView.view.frame.size.width, feedbackView.view.frame.size.height);
	[self.view addSubview:feedbackView.view];
    //[feedbackView release];
}

- (void) onExit:(int) roundNum {
	NSMutableDictionary *userData = [ShellViewController getUserData];
	NSMutableDictionary *attemptsData = [[[userData objectForKey:@"Rounds"] objectAtIndex:roundNum] objectAtIndex:0];
	[attemptsData setObject:@"In Progress" forKey:@"Status"];
	[ShellViewController writeUserData:userData];
	//NSLog(@"bookmark >>> %@", [[[attemptsData objectForKey:@"RoundsData"] objectAtIndex:roundNum] objectForKey:@"Bookmark"]);
	//[self.view removeFromSuperview];
	[[ShellViewController getInstance] loadRound:roundNum 
									withBookmark:[attemptsData objectForKey:@"Bookmark"] 
									andPageCount:[[attemptsData objectForKey:@"PageCount"] intValue]];
}

- (void) loadRoundsView {
	[self.view addSubview:roundsView];
    NSMutableDictionary *objArr = [NSMutableDictionary dictionaryWithObjectsAndKeys:roundName, @"roundName", resumeBtn, @"resumeBtn", 
                                   startNew, @"startNew", feedbackBtn, @"feedbackBtn", statusText, @"statusText", nil];
    [self populateRoundsView:0 withObjects:[objArr retain]];
    
    [objArr removeAllObjects];
    [objArr setObject:roundName2 forKey:@"roundName"];
    [objArr setObject:resumeBtn2 forKey:@"resumeBtn"];
    [objArr setObject:startNew2 forKey:@"startNew"];
    [objArr setObject:feedbackBtn2 forKey:@"feedbackBtn"];
    [objArr setObject:statusText2 forKey:@"statusText"];
    [self populateRoundsView:1 withObjects:[objArr retain]];
    
    [objArr removeAllObjects];
    [objArr setObject:roundName4 forKey:@"roundName"];
    [objArr setObject:resumeBtn4 forKey:@"resumeBtn"];
    [objArr setObject:startNew4 forKey:@"startNew"];
    [objArr setObject:feedbackBtn4 forKey:@"feedbackBtn"];
    [objArr setObject:statusText4 forKey:@"statusText"];
    [self populateRoundsView:3 withObjects:[objArr retain]];
    
    [objArr removeAllObjects];
    [objArr setObject:roundName5 forKey:@"roundName"];
    [objArr setObject:resumeBtn5 forKey:@"resumeBtn"];
    [objArr setObject:startNew5 forKey:@"startNew"];
    [objArr setObject:feedbackBtn5 forKey:@"feedbackBtn"];
    [objArr setObject:statusText5 forKey:@"statusText"];
    [self populateRoundsView:4 withObjects:[objArr retain]];

     
    [objArr removeAllObjects];
    [objArr setObject:roundName3 forKey:@"roundName"];
    [objArr setObject:resumeBtn3 forKey:@"resumeBtn"];
    [objArr setObject:startNew3 forKey:@"startNew"];
    [objArr setObject:feedbackBtn3 forKey:@"feedbackBtn"];
    [objArr setObject:statusText3 forKey:@"statusText"];
    [self populateRoundsView:2 withObjects:[objArr retain]];
    
    
    [objArr release];
    /*int totalRounds = [ShellViewController getTotalRounds];
    for (int i = 1; i<totalRounds; i++) {
        UILabel *tempLabel = [objArr objectForKey:@"roundName"];
        UILabel *roundNm = [[UILabel alloc] initWithFrame:CGRectMake(tempLabel.frame.origin.x, tempLabel.frame.origin.y + Y_DIFF, 
                                                                     tempLabel.frame.size.width, tempLabel.frame.size.height)];
        [self.view addSubview:roundNm];
        
        tempLabel = [objArr objectForKey:@"statusText"];
        UILabel *statusTxt = [[UILabel alloc] initWithFrame:CGRectMake(tempLabel.frame.origin.x, tempLabel.frame.origin.y + Y_DIFF, 
                                                                       tempLabel.frame.size.width, tempLabel.frame.size.height)];
        [self.view addSubview:statusTxt];
        
        UIButton *tempBtn = [objArr objectForKey:@"resumeBtn"];
        UIButton *resumeBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.view addSubview:[self formatBtn:resumeBn withTitle:@"Resume" andReference:tempBtn]];
        
        tempBtn = [objArr objectForKey:@"startNew"];
        UIButton *startNewBn = [[UIButton alloc] initWithFrame:CGRectMake(tempBtn.frame.origin.x, tempBtn.frame.origin.y + Y_DIFF, 
                                                                        tempBtn.frame.size.width, tempBtn.frame.size.height)];
        [self.view addSubview:startNewBn];
        
        tempBtn = [objArr objectForKey:@"feedbackBtn"];
        UIButton *feedbackBn = [[UIButton alloc] initWithFrame:CGRectMake(tempBtn.frame.origin.x, tempBtn.frame.origin.y + Y_DIFF, 
                                                                        tempBtn.frame.size.width, tempBtn.frame.size.height)];
        [self.view addSubview:feedbackBn];
        [objArr removeAllObjects];
        [objArr setObject:roundNm forKey:@"roundName"];
        [objArr setObject:resumeBn forKey:@"resumeBtn"];
        [objArr setObject:startNewBn forKey:@"startNew"];
        [objArr setObject:feedbackBn forKey:@"feedbackBtn"];
        [objArr setObject:statusTxt forKey:@"statusText"];
        //[self populateRoundsView:i withObjects:objArr];
    }*/
    
}

- (UIButton *) formatBtn:(UIButton *) btn withTitle:(NSString *) title andReference:(UIButton *) refBtn {
    btn.frame = CGRectMake(refBtn.frame.origin.x, refBtn.frame.origin.y + Y_DIFF, refBtn.frame.size.width, refBtn.frame.size.height);
    //[resumeBn addTarget:self action:@selector(choiceSelected:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
    [btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"resume_start_btn" ofType:@"png"]] forState:UIControlStateNormal];
    btn.enabled = YES;
    
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue Light" size:15.0]];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn.titleLabel setShadowColor:[UIColor blackColor]];
    [btn.titleLabel setTextAlignment:UITextAlignmentCenter];
    btn.titleLabel.text = title;
    [btn setTitle:title forState:UIControlStateNormal];
    
    NSLog(@"btn color >>> %@", btn.titleLabel.textColor);
    
    //[btn setContentHorizontalAlignment:UIControlContentVerticalAlignmentCenter];
    //[btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    
    return btn;
}

- (void) populateRoundsView:(int) roundNum withObjects:(NSMutableDictionary *) objArr{
	NSMutableDictionary *attemptsData = [[[[ShellViewController getUserData] objectForKey:@"Rounds"] objectAtIndex:roundNum] objectAtIndex:0];
    NSMutableDictionary *objects = [NSMutableDictionary dictionaryWithDictionary:objArr];
	//NSLog(@"status >>> %@", attemptsData);
    //[[objects objectForKey:@"roundName"] setText:[NSString stringWithFormat:@"%@ %d", @"Round", (roundNum + 1)]];
    [[objects objectForKey:@"roundName"] setText:[ShellViewController getNameForRound:roundNum]];
    //NSLog(@"totalRounds %@", [NSString stringWithFormat:@"%@ %d", @"Round", (roundNum + 1)]);
	if ([ShellViewController userDataExists]) {
		if ([[attemptsData objectForKey:@"Status"] isEqual:@"Not Started"] || attemptsData == nil) {
            [[objects objectForKey:@"resumeBtn"] setEnabled:NO];
            [[objects objectForKey:@"startNew"] setEnabled:YES];
            [[objects objectForKey:@"feedbackBtn"] setEnabled:NO];
		} else if ([[attemptsData objectForKey:@"Status"] isEqual:@"Completed"]) {
            [[objects objectForKey:@"resumeBtn"] setEnabled:NO];
            [[objects objectForKey:@"startNew"] setEnabled:YES];
            [[objects objectForKey:@"feedbackBtn"] setEnabled:YES];
		} else {
            [[objects objectForKey:@"resumeBtn"] setEnabled:YES];
            [[objects objectForKey:@"startNew"] setEnabled:YES];
            [[objects objectForKey:@"feedbackBtn"] setEnabled:NO];
		}
        [[objects objectForKey:@"statusText"] setText:[attemptsData objectForKey:@"Status"]];
	} else {
        [[objects objectForKey:@"resumeBtn"] setEnabled:NO];
        [[objects objectForKey:@"startNew"] setEnabled:YES];
        [[objects objectForKey:@"feedbackBtn"] setEnabled:NO];
        [[objects objectForKey:@"statusText"] setText:@"Not Started"];
	}
    [[objects objectForKey:@"resumeBtn"] setTag:roundNum];
    [[objects objectForKey:@"startNew"] setTag:roundNum];
    [[objects objectForKey:@"feedbackBtn"] setTag:roundNum];
    //startNew5.enabled=FALSE;
    
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
    
	[firstName release];
	[lastName release];
	[roundsView release];
	[submit release];
	[startNew release];
	[resumeBtn release];
	[feedbackBtn release];
	[statusText release];
    [roundName release];
	[startNew2 release];
	[resumeBtn2 release];
	[feedbackBtn2 release];
	[statusText2 release];
    [roundName2 release];
	[startNew4 release];
	[resumeBtn4 release];
	[feedbackBtn4 release];
	[statusText4 release];
    [roundName4 release];
    [startNew3 release];
	[resumeBtn3 release];
	[feedbackBtn3 release];
	[statusText3 release];
    [roundName3 release];
    [super dealloc];
}

@end
