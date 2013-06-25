//
//  Inbox.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Inbox : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
    NSArray *pageContent;
    
    UIWebView *emailType;
    UIWebView *titleText;
    UIWebView *fromText;
    UIWebView *toText;
    UIWebView *emailContent;
    UIImageView *character;
    UIImageView *emailTypeImage;
    UIWebView *instructionalText;
    UIImageView *instructionalIcon;
}

@property (nonatomic, retain) NSArray *pageContent;

@property (nonatomic, retain) IBOutlet UIWebView *emailType;
@property (nonatomic, retain) IBOutlet UIWebView *titleText;
@property (nonatomic, retain) IBOutlet UIWebView *fromText;
@property (nonatomic, retain) IBOutlet UIWebView *toText;
@property (nonatomic, retain) IBOutlet UIWebView *emailContent;
@property (nonatomic, retain) IBOutlet UIImageView *character;
@property (nonatomic, retain) IBOutlet UIImageView *emailTypeImage;
@property (nonatomic, retain) IBOutlet UIWebView *instructionalText;
@property (nonatomic, retain) IBOutlet UIImageView *instructionalIcon;

- (void) initActivity;

- (IBAction) onClose:(UIButton *) sender;

@end
