//
//  MultipleSelectMCQ.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultipleSelectMCQ : UIViewController {
	
	
	NSArray *pageContent;
	NSMutableDictionary *options;
	NSMutableDictionary *correctAnsArray;
	int setvalidationval;
	UIWebView *titleText;
	UIWebView *questionText;
	UIButton *decideBtn;
	NSMutableDictionary *choiceSeldata;
	
}

@property (nonatomic, retain) NSArray *pageContent;
@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, retain) NSMutableDictionary *correctAnsArray;
@property (nonatomic, retain) NSMutableDictionary *choiceSeldata;


@property (nonatomic, retain) IBOutlet UIWebView *titleText;
@property (nonatomic, retain) IBOutlet UIWebView *questionText;
@property (nonatomic, retain) IBOutlet UIButton *decideBtn;


- (void) initActivity;
- (void) nextPage;

- (IBAction) onDecide:(id) sender;

@end
