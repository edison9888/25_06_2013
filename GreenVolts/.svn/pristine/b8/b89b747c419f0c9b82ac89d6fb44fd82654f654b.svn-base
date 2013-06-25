//
//  MaintenanceLogDetailView.h
//  GreenVolts
//
//  Created by Shinu Mohan on 23/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintenanceLogDetailCell.h"
#import "GreenVoltsProtocol.h"


@interface MaintenanceLogDetailView : UIView<UITableViewDelegate,UITableViewDataSource>
                                            
{
    UITableView   *maintenacelogDetailTable;
    MaintenanceLogFields componentId;
    
    NSIndexPath *lastIndexPath;
}

@property(nonatomic,strong) IBOutlet MaintenanceLogDetailCell *maintenanceLogDetailCell;
@property(nonatomic,strong) NSArray *contentArray;
@property(nonatomic,strong)id<GreenVoltsProtocol>delegate;
@property(nonatomic,readwrite)MaintenanceLogFields componentid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong) NSIndexPath *lastIndexPath;

- (id)initWithFrame:(CGRect)frame titleString:(NSString *)value;

@end

