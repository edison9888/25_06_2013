//
//  LoginView.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIViewController <UIAlertViewDelegate> {
@private
	UITextField *firstName;
	UITextField *lastName;
	UIButton *submit;
	UIButton *startNew;
	UIButton *resumeBtn;
	UIButton *feedbackBtn;
	UILabel *statusText;
	UILabel *roundName;
	UIButton *startNew2;
	UIButton *resumeBtn2;
	UIButton *feedbackBtn2;
	UILabel *statusText2;
	UILabel *roundName2;
	UIButton *startNew4;
	UIButton *resumeBtn4;
	UIButton *feedbackBtn4;
	UILabel *statusText4;
	UILabel *roundName4;
	UIView *roundsView;
    UIButton *startNew3;
	UIButton *resumeBtn3;
	UIButton *feedbackBtn3;
	UILabel *statusText3;
	UILabel *roundName3;
    UIButton *startNew5;
    UIButton *resumeBtn5;
	UIButton *feedbackBtn5;
	UILabel *statusText5;
	UILabel *roundName5;
}

@property (nonatomic, retain) IBOutlet UITextField *firstName;
@property (nonatomic, retain) IBOutlet UITextField *lastName;
@property (nonatomic, retain) IBOutlet UIButton *submit;
@property (nonatomic, retain) IBOutlet UIButton *startNew;
@property (nonatomic, retain) IBOutlet UIButton *resumeBtn;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn;
@property (nonatomic, retain) IBOutlet UILabel *statusText;
@property (nonatomic, retain) IBOutlet UILabel *roundName;
@property (nonatomic, retain) IBOutlet UIButton *startNew2;
@property (nonatomic, retain) IBOutlet UIButton *resumeBtn2;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn2;
@property (nonatomic, retain) IBOutlet UILabel *statusText2;
@property (nonatomic, retain) IBOutlet UILabel *roundName2;
@property (nonatomic, retain) IBOutlet UIButton *startNew4;
@property (nonatomic, retain) IBOutlet UIButton *resumeBtn4;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn4;
@property (nonatomic, retain) IBOutlet UILabel *statusText4;
@property (nonatomic, retain) IBOutlet UILabel *roundName4;
@property (nonatomic, retain) IBOutlet UIView *roundsView;
@property (nonatomic, retain) IBOutlet UIButton *startNew3;
@property (nonatomic, retain) IBOutlet UIButton *resumeBtn3;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn3;
@property (nonatomic, retain) IBOutlet UILabel *statusText3;
@property (nonatomic, retain) IBOutlet UILabel *roundName3;
@property (nonatomic, retain) IBOutlet UIButton *startNew5;
@property (nonatomic, retain) IBOutlet UIButton *resumeBtn5;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn5;
@property (nonatomic, retain) IBOutlet UILabel *statusText5;
@property (nonatomic, retain) IBOutlet UILabel *roundName5;


- (void) onExit:(int) roundNum;
- (void) loadRoundsView;

- (IBAction) onSubmit:(id) sender;
- (IBAction) onExitCourse:(id) sender;
- (IBAction) onStartRound:(UIButton *) sender;
- (IBAction) onResumeRound:(UIButton *) sender;
- (IBAction) onFeedback:(UIButton *) sender;

@end
