//
//  Metrics.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Metrics : UIViewController {
	UILabel *totalScore;
	UIImageView *bgnd;
    UIButton *feedbackBtn;
    UILabel *feedbackLbl;
    int currentRound;
}

@property (nonatomic, retain) IBOutlet UILabel *totalScore;
@property (nonatomic, retain) IBOutlet UIImageView *bgnd;
@property (nonatomic, retain) IBOutlet UIButton *feedbackBtn;
@property (nonatomic, retain) IBOutlet UILabel *feedbackLbl;

- (IBAction) onClose:(id) sender;
- (IBAction) onFeedbackClicked:(id) sender;

- (void) initActivityWithRound:(int) currentRoundPointer;
- (void) hideFeedbackBtn:(BOOL) stat;

@end
