//
//  Inverter.h
//  GreenVolts
//
//  Created by YML on 9/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Inverter : NSObject 
@property(nonatomic) double mAC_Current;
@property(nonatomic) double mAC_Power;
@property(nonatomic) double mDC_Current;
@property(nonatomic) double mDC_Power;
@property(nonatomic) double mDC_Voltage;
@property(nonatomic) double mFrequency;
@property(nonatomic) double mGF_Current;
@property(nonatomic) double mGF_Impedance;
@property(nonatomic) double mGF_Voltage;
@property(nonatomic) double mPhase1;
@property(nonatomic) double mPhase2;
@property(nonatomic) double mPhase3;
@property(nonatomic) double mVoltage_SubString1;
@property(nonatomic) double mVoltage_SubString2;
@property(nonatomic) double mVoltage_SubString3;
@property(nonatomic) double mVoltage_SubString4;
@property(nonatomic) double mpFactor;
@property(nonatomic) double mStringNumber;
@property(nonatomic,strong) NSString *mStringName;
@end
