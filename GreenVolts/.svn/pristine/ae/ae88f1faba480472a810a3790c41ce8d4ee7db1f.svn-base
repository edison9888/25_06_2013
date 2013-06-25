//
//  MaintenanceLogDetailPickerView.h
//  GreenVolts
//
//  Created by Shinu Mohan on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GreenVoltsProtocol.h"

@interface MaintenanceLogDetailPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker *taskupdatePicker;
     UIView *notesview;
}
- (void)pickerChanged:(id)sender;
- (id)initWithFrame:(CGRect)frame andTime:(NSString*)time;
@property(nonatomic,strong)id<GreenVoltsProtocol>delegate;
@property (nonatomic,retain) NSString *currentTime;
@end

