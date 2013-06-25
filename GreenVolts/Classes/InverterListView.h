//
//  InverterListView.h
//  GreenVolts
//
//  Created by YML on 9/10/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InverterListView : UIView 
{
  UILabel *m_PowerLabel; //value
  UILabel *m_VoltageLabel; //value
  UILabel *m_CurrentLabel; //value
  UILabel *m_GFVoltageLabel; //value
  UILabel *m_GFCurrentLabel; //value
  UILabel *m_GFIMPLabel; //value
  UILabel *m_Phase1Label; //value
  UILabel *m_Phase2Label; //value
  UILabel *m_Phase3Label; //value
  UILabel *m_ACCurrentLabel; //value
  UILabel *m_PFactorLabel; //value
  UILabel *m_FrequencyLabel; //value
}
-(void)setInverterPower:(NSString*)value;
-(void)setInverterVoltage:(NSString*)value;
-(void)setInverterCurrent:(NSString*)value;
-(void)setInverterGFVoltage:(NSString*)value;
-(void)setInverterGFCurrent:(NSString*)value;
-(void)setInverterGFIMP:(NSString*)value;
-(void)setInverterPhase1:(NSString*)value;
-(void)setInverterPhase2:(NSString*)value;
-(void)setInverterPhase3:(NSString*)value;
-(void)setInverterACCurrent:(NSString*)value;
-(void)setInverterPowerFactor:(NSString*)value;
-(void)setInverterFrequency:(NSString*)value;
-(void)showDCLabels;
-(void)showACLabels;
@end
