//
//  MaintenanceLogView.h
//  GreenVolts
//
//  Created by Shinu Mohan on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintenanceLogCell.h"
#import "MaintenanceLogBarCodeView.h"
#import "GreenVoltsProtocol.h"
#import "Connection.h"
#import "SBJson.h"

@interface MaintenanceLogView : UIView<UITableViewDelegate,UITableViewDataSource,GreenVoltsProtocol,ConnectionDelegate>
{
    UITableView   *maintenacelogTable;
    UIActivityIndicatorView *m_ActivityIndicatorView;
    Connection *m_Connection;
    NSURLConnection *mURLConnection;
    NSMutableData *mResponseData;
    NSString *urlString;
    
}
- (IBAction)saveButtonTouched:(id)sender;
- (IBAction)accessoryButtonTouched:(id)sender;

//- (IBAction)cellButtonTouched:(id)sender ;
@property(nonatomic,strong)NSMutableArray *maintenanceLogArray;
@property(nonatomic,strong)NSNumber *iD;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *maintenanceAction;
@property(nonatomic,strong)NSString *componentType;
@property(nonatomic,strong)NSString *notes;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,assign)int selectedRow;

@property(nonatomic,strong)NSString *OLDBarcodeValue;
@property(nonatomic,strong)NSString *NEWBarcodevalue;

@property(nonatomic,strong) IBOutlet MaintenanceLogCell *maintenanceLogCell;
@end
