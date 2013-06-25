//
//  Inverter.m
//  GreenVolts
//
//  Created by YML on 9/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "Inverter.h"


@implementation Inverter
@synthesize mAC_Current,mAC_Power,mDC_Current,mDC_Power,mDC_Voltage,mFrequency,mGF_Current,mGF_Impedance,mGF_Voltage,mPhase1,mPhase2,
            mPhase3,mVoltage_SubString1,mVoltage_SubString2,mVoltage_SubString3,mVoltage_SubString4,mpFactor,mStringNumber,mStringName;

-(id)init
{
  if(self = [super init])
  {
    mAC_Current=0.0;
    mAC_Power=0.0;
    mDC_Current=0.0;
    mDC_Power=0.0;
    mDC_Voltage=0.0;
    mFrequency=0.0;
    mGF_Current=0.0;
    mGF_Impedance=0.0;
    mGF_Voltage=0.0;
    mPhase1=0.0;
    mPhase2=0.0;
    mPhase3=0.0;
    mVoltage_SubString1=0.0;
    mVoltage_SubString2=0.0;
    mVoltage_SubString3=0.0;
    mVoltage_SubString4=0.0;
    mpFactor=0.0;
    mStringNumber=0.0;
    mStringName=nil;
  }
  return self;
}
@end
