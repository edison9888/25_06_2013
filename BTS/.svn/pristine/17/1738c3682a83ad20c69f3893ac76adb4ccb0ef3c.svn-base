//
//  Profile.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Profile : UIViewController {
	UIView *yourProfile;
	UIView *yourCustomer;
	UIView *yourMentor;
	UIView *yourRole;
	UIWebView *yourDescription;
	UIWebView *customerDescription;
	UIWebView *mentorDescription;
	UIWebView *roleDescription;
	UIImageView *mentor;
	
	NSDictionary *listOfViews;
	NSDictionary *listOfWebViews;
}

@property (nonatomic, retain) IBOutlet UIView *yourProfile;
@property (nonatomic, retain) IBOutlet UIView *yourCustomer;
@property (nonatomic, retain) IBOutlet UIView *yourMentor;
@property (nonatomic, retain) IBOutlet UIView *yourRole;
@property (nonatomic, retain) IBOutlet UIWebView *yourDescription;
@property (nonatomic, retain) IBOutlet UIWebView *customerDescription;
@property (nonatomic, retain) IBOutlet UIWebView *mentorDescription;
@property (nonatomic, retain) IBOutlet UIWebView *roleDescription;
@property (nonatomic, retain) IBOutlet UIImageView *mentor;

@property (nonatomic, retain) NSDictionary *listOfViews;
@property (nonatomic, retain) NSDictionary *listOfWebViews;

- (void) loadViewWithName:(NSString *) viewName andContent:content;
- (void) onClose:(id) sender;

@end
