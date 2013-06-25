//
//  TextOnlyTemplate.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextOnlyTemplate : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
	NSArray *pageContent;
	
	UIWebView *descriptionText;
	UIButton *continueBtn;
    UIWebView *instructionalText;
    UIImageView *instructionalIcon;
}

@property (nonatomic, retain) NSArray *pageContent;

@property (nonatomic, retain) IBOutlet UIWebView *descriptionText;
@property (nonatomic, retain) IBOutlet UIButton *continueBtn;
@property (nonatomic, retain) IBOutlet UIWebView *instructionalText;
@property (nonatomic, retain) IBOutlet UIImageView *instructionalIcon;

- (IBAction) onContinue:(id) sender;

- (void) initActivity;
- (void) hideContinueBtn:(BOOL) status;
- (void) nextPage;

@end
