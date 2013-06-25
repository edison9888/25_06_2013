//
//  MaintenancePlanViewController.h
//  GreenVolts
//
//  Created by Rapidvalue on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintenancePlan.h"

@interface MaintenancePlanCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *locationlabel;
@property (nonatomic,strong) IBOutlet UILabel *activitylabel;

@property (nonatomic,strong) IBOutlet UILabel *location;
@property (nonatomic, strong) IBOutlet UILabel *activity;
@property (nonatomic,strong) IBOutlet UIButton *accessoryButton;

- (void)displayDetails:(MaintenancePlan *)result rowValue:(int)row;
-(void) hideAllUIElements;
-(void) unHideAllUIElements;


@end
