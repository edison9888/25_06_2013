//
//  Feedback.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Feedback : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
	NSMutableArray *pageContent;
	NSMutableDictionary *options;
	NSMutableDictionary *KPIViewsArr;
	NSMutableArray *decisionsArr;
    int currentRound;
    int choiceSelected;
	
	UIWebView *feedbackText;
	UIButton *closeBtn;
    UIWebView *instructionalText;
    UIImageView *instructionalIcon;
    UIWebView *scoresTitle;
}

@property (nonatomic, retain) NSMutableArray *pageContent;
@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, retain) NSMutableDictionary *KPIViewsArr;
@property (nonatomic, retain) NSMutableArray *decisionsArr;
@property (nonatomic, retain) IBOutlet UIWebView *feedbackText;
@property (nonatomic, retain) IBOutlet UIButton *closeBtn;
@property (nonatomic, retain) IBOutlet UIWebView *instructionalText;
@property (nonatomic, retain) IBOutlet UIImageView *instructionalIcon;
@property (nonatomic, retain) IBOutlet UIWebView *scoresTitle;

- (void) initActivityWithRound:(int) currentRoundPointer;

- (IBAction) onClose:(id) sender;
- (IBAction) onMetricsClicked:(id) sender;

@end
