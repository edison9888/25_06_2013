//
//  InverterListView.m
//  GreenVolts
//
//  Created by YML on 9/10/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "InverterListView.h"

@implementation InverterListView

- (id)initWithFrame:(CGRect)frame 
{    
  self = [super initWithFrame:frame];
  if (self) 
  {
    self.backgroundColor=[UIColor clearColor];
    
    m_PowerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,2, 50,8)];
    [m_PowerLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_PowerLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_PowerLabel.backgroundColor=[UIColor clearColor];
    m_PowerLabel.textAlignment=UITextAlignmentLeft;
    [self addSubview:m_PowerLabel];
    
    m_VoltageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,12, 50,8)];
    [m_VoltageLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_VoltageLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_VoltageLabel.backgroundColor=[UIColor clearColor];
    m_VoltageLabel.textAlignment=UITextAlignmentLeft;
    m_VoltageLabel.hidden=YES;
    [self addSubview:m_VoltageLabel];
    
    m_Phase1Label=[[UILabel alloc]initWithFrame:CGRectMake(0,12, 50,8)];
    [m_Phase1Label setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_Phase1Label.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_Phase1Label.backgroundColor=[UIColor clearColor];
    m_Phase1Label.textAlignment=UITextAlignmentLeft;
    m_Phase1Label.hidden=YES;
    [self addSubview:m_Phase1Label];
    
    m_CurrentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,22, 50,8)];
    [m_CurrentLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_CurrentLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_CurrentLabel.backgroundColor=[UIColor clearColor];
    m_CurrentLabel.textAlignment=UITextAlignmentLeft;
    m_CurrentLabel.hidden=YES;
    [self addSubview:m_CurrentLabel];
    
    m_Phase2Label=[[UILabel alloc]initWithFrame:CGRectMake(0,22, 50,8)];
    [m_Phase2Label setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_Phase2Label.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_Phase2Label.backgroundColor=[UIColor clearColor];
    m_Phase2Label.textAlignment=UITextAlignmentLeft;
    m_Phase2Label.hidden=YES;
    [self addSubview:m_Phase2Label];
    
    m_GFVoltageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,32, 50,8)];
    [m_GFVoltageLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_GFVoltageLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_GFVoltageLabel.backgroundColor=[UIColor clearColor];
    m_GFVoltageLabel.textAlignment=UITextAlignmentLeft;
    m_GFVoltageLabel.hidden=YES;
    [self addSubview:m_GFVoltageLabel];
    
    m_Phase3Label=[[UILabel alloc]initWithFrame:CGRectMake(0,32, 50,8)];
    [m_Phase3Label setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_Phase3Label.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_Phase3Label.backgroundColor=[UIColor clearColor];
    m_Phase3Label.textAlignment=UITextAlignmentLeft;
    m_Phase3Label.hidden=YES;
    [self addSubview:m_Phase3Label];
    
    m_GFCurrentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,42, 50,8)];
    [m_GFCurrentLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_GFCurrentLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_GFCurrentLabel.backgroundColor=[UIColor clearColor];
    m_GFCurrentLabel.textAlignment=UITextAlignmentLeft;
    m_GFCurrentLabel.hidden=YES;
    [self addSubview:m_GFCurrentLabel];
    
    m_GFIMPLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,52, 50,8)];
    [m_GFIMPLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_GFIMPLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_GFIMPLabel.backgroundColor=[UIColor clearColor];
    m_GFIMPLabel.textAlignment=UITextAlignmentLeft;
    m_GFIMPLabel.hidden=YES;
    [self addSubview:m_GFIMPLabel];
    
    m_PFactorLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,52, 50,8)];
    [m_PFactorLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_PFactorLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_PFactorLabel.backgroundColor=[UIColor clearColor];
    m_PFactorLabel.textAlignment=UITextAlignmentLeft;
    m_PFactorLabel.hidden=YES;
    [self addSubview:m_PFactorLabel];
    
    m_FrequencyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,62, 50,8)];
    [m_FrequencyLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_FrequencyLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_FrequencyLabel.backgroundColor=[UIColor clearColor];
    m_FrequencyLabel.textAlignment=UITextAlignmentLeft;
    m_FrequencyLabel.hidden=YES;
    [self addSubview:m_FrequencyLabel];
  }
  return self;
}
-(void)dealloc
{
  //printf("Dealloc in InverterListView\n");
  [m_PowerLabel removeFromSuperview];
  [m_VoltageLabel removeFromSuperview];
  [m_CurrentLabel removeFromSuperview];
  [m_GFVoltageLabel removeFromSuperview];
  [m_GFCurrentLabel removeFromSuperview];
  [m_GFIMPLabel removeFromSuperview];
  [m_Phase1Label removeFromSuperview];
  [m_Phase2Label removeFromSuperview];
  [m_Phase3Label removeFromSuperview];
  [m_ACCurrentLabel removeFromSuperview];
  [m_PFactorLabel removeFromSuperview];
  [m_FrequencyLabel removeFromSuperview];
}
-(void)showACLabels
{
  m_Phase1Label.hidden=NO;
  m_Phase2Label.hidden=NO;
  m_Phase3Label.hidden=NO;
  m_CurrentLabel.hidden=NO;
  m_PFactorLabel.hidden=NO;
  m_FrequencyLabel.hidden=NO;
  
  m_CurrentLabel.frame=CGRectMake(0,42, 50,8);
}

-(void)showDCLabels
{
  m_VoltageLabel.hidden=NO;
  m_CurrentLabel.hidden=NO;
  m_GFVoltageLabel.hidden=NO;
  m_GFCurrentLabel.hidden=NO;
  m_GFIMPLabel.hidden=NO;
}

#pragma mark -- UI updation methods
-(void)setInverterPower:(NSString*)value
{
  m_PowerLabel.text=value;
}
-(void)setInverterVoltage:(NSString*)value
{
  m_VoltageLabel.text=value;
}
-(void)setInverterCurrent:(NSString*)value
{
  m_CurrentLabel.text=value;
}
-(void)setInverterGFVoltage:(NSString*)value
{
  m_GFVoltageLabel.text=value;
}
-(void)setInverterGFCurrent:(NSString*)value
{
  m_GFCurrentLabel.text=value;
}
-(void)setInverterGFIMP:(NSString*)value
{
  m_GFIMPLabel.text=value;
}
-(void)setInverterPhase1:(NSString*)value
{
  m_Phase1Label.text=value;
}
-(void)setInverterPhase2:(NSString*)value
{
  m_Phase2Label.text=value;
}
-(void)setInverterPhase3:(NSString*)value
{
  m_Phase3Label.text=value;
}
-(void)setInverterACCurrent:(NSString*)value
{
  m_ACCurrentLabel.text=value;
}
-(void)setInverterPowerFactor:(NSString*)value
{
  m_PFactorLabel.text=value;
}
-(void)setInverterFrequency:(NSString*)value
{
  m_FrequencyLabel.text=value;
}

@end
