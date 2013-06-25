//
//  ShellViewController.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShellViewController : UIViewController <UIPopoverControllerDelegate, UIGestureRecognizerDelegate> {
	int currentRoundPointer;
	int pagePointer;
	int totalPages;
	int pageCount;
	
	NSMutableArray *templateObjects;
	NSString *currentTemplate;
	NSString *defaultImageExtn;
	NSMutableArray *currentRoundStructure;
	NSMutableDictionary *pagesInfo;
	NSDictionary *currentRoundInfo;
	NSString *currentRoundTitle;
	NSMutableArray *currentPageContent;
	
	UIView *templateView;
	UIProgressView *progressBar;
	UILabel *progressPercent;
	UIImageView *bgnd;
	UIButton *profileBtn;
	UIButton *inboxBtn;
	UIButton *metricsBtn;
	UIButton *resourcesBtn;
	UIButton *feedbackBtn;
	UIPopoverController *profilePopover;
	UISwipeGestureRecognizer *recognizer;
//	UIView *profileLayer;
}

@property (nonatomic, retain) NSMutableArray *templateObjects;
@property (nonatomic, retain) NSString *currentTemplate;
@property (nonatomic, retain) NSString *defaultImageExtn;
@property (nonatomic, retain) NSMutableArray *currentRoundStructure;
@property (nonatomic, retain) NSMutableDictionary *pagesInfo;
@property (nonatomic, retain) NSDictionary *currentRoundInfo;
@property (nonatomic, retain) NSString *currentRoundTitle;
@property (nonatomic, retain) NSMutableArray *currentPageContent;

@property (nonatomic, retain) IBOutlet UIView *templateView;
@property (nonatomic, retain) IBOutlet UIProgressView *progressBar;
@property (nonatomic, retain) IBOutlet UILabel *progressPercent;
@property (nonatomic, retain) IBOutlet UIImageView *bgnd;
@property (nonatomic, retain) IBOutlet UIButton *profileBtn;
@property (nonatomic, retain) IBOutlet UIButton *inboxBtn;
@property (nonatomic, retain) IBOutlet UIButton *metricsBtn;
@property (nonatomic, retain) IBOutlet UIButton *resourcesBtn;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn;
@property (nonatomic, retain) IBOutlet UIPopoverController *profilePopover;
//@property (nonatomic, retain) IBOutlet UIView *profileLayer;
@property (nonatomic, retain) UISwipeGestureRecognizer *recognizer;

+ (ShellViewController *) getInstance;
+ (int) getTotalRounds;
+ (int) getCurrentRound;
+ (NSArray *) getCurrentRoundKPIs;
+ (NSArray *) getCurrentRoundMaxKPIs;
+ (NSArray *) getKPIsForRound:(int) roundNum;
+ (NSArray *) getMaxKPIsForRound:(int) roundNum;
+ (NSString *) getNameForRound:(int) roundNum;
+ (NSString *) getEmailText;
+ (NSString *) getVoicemailText;
+ (NSString *) getScrollDownInstructionalText;
+ (void) writeUserData:(NSMutableDictionary *) newUserData;
+ (NSMutableDictionary *) getUserData;
+ (void) saveDecisionData:(NSMutableDictionary *) decisionData forID:(NSString *) pageID;
+ (void) updateKPIs:(NSMutableDictionary *) kpi;
+ (void) setAttemptComplete;
+ (BOOL) userDataExists;
+ (BOOL) createNewUserData;
+ (BOOL) removeUserDataPlist;

- (NSArray *) getPageContent;
- (void) initActivity;
- (void) loadPageById:(NSString *) pageID;
- (void) removeAllViews;
- (void) removeModalView:(UIViewController *) modalVC;
- (void) loadRound:(int) roundNum withBookmark:(NSString *) bookmark andPageCount:(int) pageCnt;
- (void) showProfileWithView:(NSString *) viewName;
- (void) addSwipeGastures;
- (void) highlight:(BOOL) highlight Btn:(NSString *) btnName;
- (void) enable:(BOOL) enable Btn:(NSString *) btnName;

- (IBAction) onProfileClicked:(id) sender;
- (IBAction) onInboxClicked:(id) sender;
- (IBAction) onMetricsClicked:(id) sender;
- (IBAction) onResourcesClicked:(id) sender;
- (IBAction) onFeedbackClicked:(id) sender;
- (IBAction) onMainMenuClicked:(id) sender;

@end
