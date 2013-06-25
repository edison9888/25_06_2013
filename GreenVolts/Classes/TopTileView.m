//
//  TopTileView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "TopTileView.h"


@implementation TopTileView
- (id)initWithFrame:(CGRect)frame
{    
  self = [super initWithFrame:frame];
  if (self) 
  {
    
    frame.origin.x=0.0;
    frame.origin.y=0.0;	
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *m_PowerProductionImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,90, 64)];
    m_PowerProductionImageView.image=[UIImage imageNamed:@"TopEnergyDial.png"];
    [self addSubview:m_PowerProductionImageView];
    
    UILabel *kwLabel=[[UILabel alloc]initWithFrame:CGRectMake(35,52,20,10)];
    kwLabel.text=@"kW";
    kwLabel.font=[UIFont fontWithName:@"Arial" size:8];
    kwLabel.backgroundColor=[UIColor clearColor];
    kwLabel.textAlignment=UITextAlignmentCenter;
    kwLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    [m_PowerProductionImageView addSubview:kwLabel];
    
    
    UIImageView *m_PVSDNIImageView=[[UIImageView alloc]initWithFrame:CGRectMake(110, 2, 88, 62)];
    m_PVSDNIImageView.image=[UIImage imageNamed:@"SmallDial.png"];
    [self addSubview:m_PVSDNIImageView];
    
    m_ValueLabel1=[[UILabel alloc]initWithFrame:CGRectMake(-17, 13, 30, 93)];
    [m_ValueLabel1 setFont:[UIFont fontWithName:@"Arial" size:7]]; // 6
    m_ValueLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel1.backgroundColor=[UIColor clearColor];
    m_ValueLabel1.textAlignment=UITextAlignmentRight;
    m_ValueLabel1.text=@"0";
    [self addSubview:m_ValueLabel1];
    
    m_ValueLabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, -22, 30, 93)];
    [m_ValueLabel2 setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_ValueLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel2.backgroundColor=[UIColor clearColor];
    m_ValueLabel2.textAlignment=UITextAlignmentRight;
    m_ValueLabel2.text=@"8";
    [self addSubview:m_ValueLabel2];
    
      
    m_ValueLabel3=[[UILabel alloc]initWithFrame:CGRectMake(30,-37, 30, 93)]; // 31 -40 30 93
    [m_ValueLabel3 setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_ValueLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel3.backgroundColor=[UIColor clearColor];
    m_ValueLabel3.textAlignment=UITextAlignmentCenter;
    m_ValueLabel3.text=@"16";
    [self addSubview:m_ValueLabel3];
      
    m_ValueLabel4=[[UILabel alloc]initWithFrame:CGRectMake(70, -22, 30, 93)]; // 77 -22 30 93
    [m_ValueLabel4 setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_ValueLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0]; // 95.1 97 
    m_ValueLabel4.backgroundColor=[UIColor clearColor];
    m_ValueLabel4.textAlignment=UITextAlignmentLeft;
    m_ValueLabel4.text=@"24";
    [self addSubview:m_ValueLabel4];
    
    m_ValueLabel5=[[UILabel alloc]initWithFrame:CGRectMake(64, 13, 30, 93)]; // 77 13 30 93
    [m_ValueLabel5 setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_ValueLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel5.backgroundColor=[UIColor clearColor];
    m_ValueLabel5.textAlignment=UITextAlignmentCenter;
    m_ValueLabel5.text=@"32";
    [self addSubview:m_ValueLabel5];
    
    UILabel *pLabel1=[[UILabel alloc]initWithFrame:CGRectMake(120, 13, 30, 93)];
    [pLabel1 setFont:[UIFont fontWithName:@"Arial" size:6]];
    pLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel1.backgroundColor=[UIColor clearColor];
    pLabel1.text=@"0";
    [self addSubview:pLabel1];
    
    UILabel *pLabel2=[[UILabel alloc]initWithFrame:CGRectMake(120, -21, 30, 93)]; // 118 -22 30 93
    [pLabel2 setFont:[UIFont fontWithName:@"Arial" size:6]];
    pLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel2.backgroundColor=[UIColor clearColor];
    pLabel2.text=@"300";
    [self addSubview:pLabel2];
    
    UILabel *pLabel3=[[UILabel alloc]initWithFrame:CGRectMake(149,-35, 30, 93)]; // 149 -38 30 93
    [pLabel3 setFont:[UIFont fontWithName:@"Arial" size:6]];
    pLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel3.backgroundColor=[UIColor clearColor];
    pLabel3.text=@"600";
    [self addSubview:pLabel3];
    
    UILabel *pLabel4=[[UILabel alloc]initWithFrame:CGRectMake(178, -21, 30, 93)]; // 182 -22 30 93
    [pLabel4 setFont:[UIFont fontWithName:@"Arial" size:6]];
    pLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel4.backgroundColor=[UIColor clearColor];
    pLabel4.text=@"900";
    [self addSubview:pLabel4];
    
    UILabel *pLabel5=[[UILabel alloc]initWithFrame:CGRectMake(182, 13, 30, 93)];
    [pLabel5 setFont:[UIFont fontWithName:@"Arial" size:6]];
    pLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel5.backgroundColor=[UIColor clearColor];
    pLabel5.text=@"1200";
    [self addSubview:pLabel5];      
    
    UILabel *pTodayKWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14, 35, 131, 93)];
    [pTodayKWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pTodayKWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pTodayKWHTitleLabel.backgroundColor=[UIColor clearColor];
    pTodayKWHTitleLabel.text=@"Today kWh";
    [self addSubview:pTodayKWHTitleLabel];      
    
    UILabel *pTodayKWHSeperator=[[UILabel alloc]initWithFrame:CGRectMake(53, 35, 131, 93)];
    [pTodayKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pTodayKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pTodayKWHSeperator.backgroundColor=[UIColor clearColor];
    pTodayKWHSeperator.text=@"|";
    [self addSubview:pTodayKWHSeperator];  
      
    m_TodayKWHValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(58, 35, 131, 93)]; // 58 25 131 93
    [m_TodayKWHValueLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_TodayKWHValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_TodayKWHValueLabel.backgroundColor=[UIColor clearColor];
    m_TodayKWHValueLabel.text=@"1915";
    [self addSubview:m_TodayKWHValueLabel];
    
    UILabel *pCurrentkWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(17, 25, 131, 93)];
    [pCurrentkWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pCurrentkWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pCurrentkWHTitleLabel.backgroundColor=[UIColor clearColor];
    pCurrentkWHTitleLabel.text=@"Power kW";
    [self addSubview:pCurrentkWHTitleLabel];      
      
    UILabel *pYTDKWHSeperator=[[UILabel alloc]initWithFrame:CGRectMake(53, 25, 131, 93)];
    [pYTDKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pYTDKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pYTDKWHSeperator.backgroundColor=[UIColor clearColor];
    pYTDKWHSeperator.text=@"|";
    [self addSubview:pYTDKWHSeperator];    
    
    m_CurrentKWValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(58, 25, 131, 93)]; // 58 35 131 93
    [m_CurrentKWValueLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_CurrentKWValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_CurrentKWValueLabel.backgroundColor=[UIColor clearColor];
    m_CurrentKWValueLabel.text=@"13802";
    [self addSubview:m_CurrentKWValueLabel];
    
    UILabel *pDNITitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 25, 50, 93)];
    [pDNITitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pDNITitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pDNITitleLabel.backgroundColor=[UIColor clearColor];
    pDNITitleLabel.text=@"DNI";
    [self addSubview:pDNITitleLabel];      
    
    UILabel *pDNISeperator=[[UILabel alloc]initWithFrame:CGRectMake(154, 25, 131, 93)];
    [pDNISeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pDNISeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pDNISeperator.backgroundColor=[UIColor clearColor];
    pDNISeperator.text=@"|";
    [self addSubview:pDNISeperator];  
     
    m_DNIVlaueLabel=[[UILabel alloc]initWithFrame:CGRectMake(159, 25, 131, 93)];
    [m_DNIVlaueLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_DNIVlaueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_DNIVlaueLabel.backgroundColor=[UIColor clearColor];
    m_DNIVlaueLabel.text=@"600";
    [self addSubview:m_DNIVlaueLabel];
    
    m_ModeLabel=[[UILabel alloc]initWithFrame:CGRectMake(228, 25, 131, 93)];
    [m_ModeLabel setFont:[UIFont fontWithName:@"Arial" size:6.5]];
    m_ModeLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.) blue:0.0 alpha:1.0];  
    m_ModeLabel.backgroundColor=[UIColor clearColor];
    m_ModeLabel.text=@"Mode";
    [self addSubview:m_ModeLabel]; 
      
    m_OperationalMode=[[UILabel alloc]initWithFrame:CGRectMake(252, 25, 131, 93)];
    [m_OperationalMode setFont:[UIFont fontWithName:@"Arial" size:6.5]];
    m_OperationalMode.textColor=[UIColor colorWithRed:(39.6/100.) green:(80.4/100.) blue:0.0 alpha:1.0];
    m_OperationalMode.backgroundColor=[UIColor clearColor];
    m_OperationalMode.text=@"";
    [self addSubview:m_OperationalMode];
                         
    m_OperationRect=[[GVRect alloc]initWithFrame:CGRectMake(249, 65, 38, 12)];
    m_OperationRect.visible=NO;
    m_OperationRect.backgroundColor=[UIColor clearColor];
    [self addSubview:m_OperationRect];
      
    UILabel *pTimeTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(136, 35,50, 93)];
    [pTimeTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pTimeTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pTimeTitleLabel.backgroundColor=[UIColor clearColor];
    pTimeTitleLabel.text=@"Time";
    [self addSubview:pTimeTitleLabel];      
    
    UILabel *pTimeSeperator=[[UILabel alloc]initWithFrame:CGRectMake(154, 35, 131, 93)];
    [pTimeSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pTimeSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pTimeSeperator.backgroundColor=[UIColor clearColor];
    pTimeSeperator.text=@"|";
    [self addSubview:pTimeSeperator]; 
      
    m_TimeValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(159, 35, 50, 93)];
    [m_TimeValueLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_TimeValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_TimeValueLabel.backgroundColor=[UIColor clearColor];
    m_TimeValueLabel.text=@"12:34";
    [self addSubview:m_TimeValueLabel];      
    
    m_AlertImageView=[[UIImageView alloc]initWithFrame:CGRectMake(226, 45, 8, 8)];
    m_AlertImageView.image=[UIImage imageNamed:@"Alert-Green.png"];
    [self addSubview:m_AlertImageView];
    
    UILabel *pAlertLabel=[[UILabel alloc]initWithFrame:CGRectMake(239, 40, 50, 20)];
    [pAlertLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:11]];
    pAlertLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pAlertLabel.backgroundColor=[UIColor clearColor];
    pAlertLabel.text=@"Alerts";
    [self addSubview:pAlertLabel];      
    
    m_WheatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(202, 10, 20, 20)];
    m_WheatherImageView.image=[UIImage imageNamed:@"Sun-icon.png"];
    [self addSubview:m_WheatherImageView];
    
    m_SiteWeatherDescLabel=[[UILabel alloc]initWithFrame:CGRectMake(226, 11, 85, 20)];
    m_SiteWeatherDescLabel.textColor=[UIColor whiteColor];
    m_SiteWeatherDescLabel.backgroundColor=[UIColor clearColor];
    [m_SiteWeatherDescLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7.5]];
    m_SiteWeatherDescLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_SiteWeatherDescLabel.text=@"Party Cloudy";
    [self addSubview:m_SiteWeatherDescLabel];
    
    UILabel *pSiteWeatherDescLabel=[[UILabel alloc]initWithFrame:CGRectMake(228, 11, 85, 20)];
    pSiteWeatherDescLabel.textColor=[UIColor whiteColor];
    pSiteWeatherDescLabel.backgroundColor=[UIColor clearColor];
    [pSiteWeatherDescLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7.5]];
    pSiteWeatherDescLabel.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pSiteWeatherDescLabel.text=@"|";
    [self addSubview:pSiteWeatherDescLabel];         
    
    m_WindInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(226, 21, 80, 20)];
    m_WindInfoLabel.textColor=[UIColor whiteColor];
    m_WindInfoLabel.backgroundColor=[UIColor clearColor];
    [m_WindInfoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7.5]];
    m_WindInfoLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_WindInfoLabel.text=@" | NorthEast 2.5m/s";
    [self addSubview:m_WindInfoLabel];
    
    UILabel *pWindInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(228, 21, 80, 20)];
    pWindInfoLabel.textColor=[UIColor whiteColor];
    pWindInfoLabel.backgroundColor=[UIColor clearColor];
    [pWindInfoLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7.5]];
    pWindInfoLabel.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pWindInfoLabel.text=@"|";
    [self addSubview:pWindInfoLabel];   
    
    m_PowerProductionNeedleView=[[UIImageView alloc]initWithFrame:CGRectMake(40.5, -1, 9, 92)];
    m_PowerProductionNeedleView.image=[UIImage imageNamed:@"EnergyNeedle.png"];
    [self addSubview:m_PowerProductionNeedleView];
    
    m_PVSDNINeedleView=[[UIImageView alloc]initWithFrame:CGRectMake(39.75+110, -1.5+2, 8.5, 91)];
    m_PVSDNINeedleView.image=[UIImage imageNamed:@"DNINeedle.png"];
    [self addSubview:m_PVSDNINeedleView];            
  }
  return self;
}
-(void)dealloc
{
  //printf("Dealloc in TopTileView\n");
}
#pragma mark UI update methods
-(void)setCurrentKWValue:(NSString*)value {
  m_CurrentKWValueLabel.text = value == nil ? @"" : [NSString stringWithFormat:@"%.1f", [value floatValue]];
}
-(void)setTopTileAlertImageName:(NSString*)value
{
  m_AlertImageView.image=[UIImage imageNamed:value];
}
-(void)setTopTilePowerProductionNeedleRotationAngle:(float)angle
{
  [m_PowerProductionNeedleView setTransform:CGAffineTransformMakeRotation(angle)];
}
-(void)setTopTilePowerVsDNINeedleRotationAngle:(float)angle
{
  [m_PVSDNINeedleView setTransform:CGAffineTransformMakeRotation(angle)];
}
-(void)setTopTileWeatherImageName:(NSString*)value
{
  m_WheatherImageView.image=[UIImage imageNamed:value];
}
-(void)setTopTileTodayKWH:(NSString*)value
{
  m_TodayKWHValueLabel.text=value;
}
-(void)setTopTileDNI:(NSString*)value
{
  m_DNIVlaueLabel.text=value;
}
-(void)setTopTileTime:(NSString*)value
{
  m_TimeValueLabel.text=value;
}
-(void)setTopTileWeatherDescription:(NSString*)value
{
  m_SiteWeatherDescLabel.text=value;
}
-(void)setTopTileWindInfo:(NSString*)value
{
  m_WindInfoLabel.text=value;
}
-(void)setTopTileValue1:(NSString*)value
{
  m_ValueLabel1.text=value;
}
-(void)setTopTileValue2:(NSString*)value
{
  m_ValueLabel2.text=value;
}
-(void)setTopTileValue3:(NSString*)value
{
  m_ValueLabel3.text=value;
}
-(void)setTopTileValue4:(NSString*)value
{
  m_ValueLabel4.text=value;
}
-(void)setTopTileValue5:(NSString*)value
{
  m_ValueLabel5.text=value;
}
-(void)setOperationalMode:(NSString *)value {
    m_OperationalMode.text=value;
}
-(void)hideOperationMode:(BOOL)hide {
    if (!hide) {
        m_ModeLabel.text=@"Mode";
    }
    else {
        m_ModeLabel.text=@"";
        m_OperationalMode.text=@"";
    }
    m_OperationRect.visible=!hide;
    [m_OperationRect setNeedsDisplay];
}
@end
