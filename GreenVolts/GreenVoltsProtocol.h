//
//  BackButtonTouchProtocol.h
//  GreenVolts
//
//  Created by Rapidvalue on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GreenVoltsProtocol <NSObject>
-(void)backButtonTouched:(id)currentobject;
-(void)barcodeScanSuccessfull:(id)currentobject barcodeNumber:(NSString *)barcodeValue;
-(void)logdetailtaskselected:(NSString*)result:(MaintenanceLogFields)componentId;
-(void)logDetailNoteSaved:(NSString*)savedString componentID:(MaintenanceLogFields)componentid;
-(void)pickerUpdateToLog:(NSString*)dateString;
@end
