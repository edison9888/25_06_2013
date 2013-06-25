//
//  MaintenanceLogBarCodeView.h
//  GreenVolts
//
//  Created by Shinu Mohan on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "GreenVoltsProtocol.h"

//@protocol BackButtonTouchedDelegate<NSObject>
//    -(void)backButtonTouched:(id)currentView;
//@end

@interface MaintenanceLogBarCodeView : UIViewController<ZBarReaderDelegate>

@property(nonatomic,assign)BOOL isOLDBarCodeReader;
@property(nonatomic,strong)NSString *barcodeNumber;
@property(nonatomic,strong)id<GreenVoltsProtocol>delegate;
@end
