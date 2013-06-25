//
//  MaintenanceLogDetailNotesView.h
//  GreenVolts
//
//  Created by Shinu Mohan on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreenVoltsProtocol.h"
@interface MaintenanceLogDetailNotesView : UIView<UITextViewDelegate>
{
    UIButton *notessavebutton;
    UITextView *detailtextView;
    UIView *notesview;
    NSString *textViewString;
    MaintenanceLogFields componentId;
}
-(void)notessavedonButtonclick;
- (id)initWithFrame:(CGRect)frame andNotes:(NSString*)notes;

@property (nonatomic, retain) UITextView *detailtextView;
@property (nonatomic,retain) NSString *currentNotes;
@property(nonatomic,strong)id<GreenVoltsProtocol>delegate;
@property(nonatomic,readwrite)MaintenanceLogFields componentid;
@end
