//
//  InboxTemplate.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InboxTemplate : UIViewController {
    UIWebView *inboxContents;
}

@property (nonatomic, retain) IBOutlet UIWebView *inboxContents;

- (void) initActivity;
- (void) nextPage;

@end
