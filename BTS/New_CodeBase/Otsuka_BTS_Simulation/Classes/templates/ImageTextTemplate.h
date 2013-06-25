//
//  ImageTextTemplate.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextTemplate : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
	NSArray *pageContent;
	
	UIButton *continueBtn;
	UIWebView *descriptionText;
	UIImageView *character;
    UIWebView *instructionalText;
    UIImageView *instructionalIcon;
}

@property (nonatomic, retain) NSArray *pageContent;

@property (nonatomic, retain) IBOutlet UIButton *continueBtn;
@property (nonatomic, retain) IBOutlet UIWebView *descriptionText;
@property (nonatomic, retain) IBOutlet UIImageView *character;
@property (nonatomic, retain) IBOutlet UIWebView *instructionalText;
@property (nonatomic, retain) IBOutlet UIImageView *instructionalIcon;

- (IBAction) onContinue:(id) sender;

- (void) initActivity;
- (void) nextPage;
- (void) flashTableScrollIndicatorsForText:(UIScrollView *) scrollVw;

@end
