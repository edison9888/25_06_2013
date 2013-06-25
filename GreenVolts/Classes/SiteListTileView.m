//
//  SiteListTileView.m
//  GreenVolts
//
//  Created by YML on 8/26/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "SiteListTileView.h"

@implementation SiteListTileView

- (id)initWithFrame:(CGRect)frame
{    
  self = [super initWithFrame:frame];
  if (self) 
  {
    frame.origin.x=0;
    frame.origin.y=0;
    
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *backgroundImageView=[[UIImageView alloc]init];
    backgroundImageView.frame=frame;
    backgroundImageView.image=[UIImage imageNamed:@"Portfolio_TableviewBG.png"];
    [self addSubview:backgroundImageView];
    
    m_SiteNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 15)];
    m_SiteNameLabel.textColor=[UIColor whiteColor];
    [m_SiteNameLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
    m_SiteNameLabel.backgroundColor=[UIColor clearColor];
    m_SiteNameLabel.text=@"Mission Falls";
    [self addSubview:m_SiteNameLabel];
    
    m_SiteLocationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 18, 100, 15)];
    m_SiteLocationLabel.textColor=[UIColor colorWithRed:(51.0/100.0) green:(51.0/100.0) blue:(51.0/100.0) alpha:1.0];
    m_SiteLocationLabel.backgroundColor=[UIColor clearColor];
    [m_SiteLocationLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_SiteLocationLabel.text=@"Fremont, CA";
    [self addSubview:m_SiteLocationLabel];
    
    m_SiteTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(168, 2, 50, 20)];
    m_SiteTimeLabel.textColor=[UIColor whiteColor];
    m_SiteTimeLabel.backgroundColor=[UIColor clearColor];
    [m_SiteTimeLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_SiteTimeLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_SiteTimeLabel.text=@"13:45";
    [self addSubview:m_SiteTimeLabel];
    
    m_SiteWeatherDescLabel=[[UILabel alloc]initWithFrame:CGRectMake(168, 17, 70, 20)];
    m_SiteWeatherDescLabel.textColor=[UIColor whiteColor];
    m_SiteWeatherDescLabel.backgroundColor=[UIColor clearColor];
    [m_SiteWeatherDescLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_SiteWeatherDescLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_SiteWeatherDescLabel.text=@"PartyCloudy";
    [self addSubview:m_SiteWeatherDescLabel];
    
    m_SiteTempLabel=[[UILabel alloc]initWithFrame:CGRectMake(230, 17, 50, 20)];
    m_SiteTempLabel.backgroundColor=[UIColor clearColor];
    [m_SiteTempLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_SiteTempLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_SiteTempLabel.text=@"19°C";
    [self addSubview:m_SiteTempLabel];
    
    m_TodayEPLabel=[[UILabel alloc]initWithFrame:CGRectMake(94, 123, 70, 20)];
    [m_TodayEPLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_TodayEPLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_TodayEPLabel.backgroundColor=[UIColor clearColor];
    m_TodayEPLabel.text=@"91";
    [self addSubview:m_TodayEPLabel];
    
    m_YTDEPLabel=[[UILabel alloc]initWithFrame:CGRectMake(94, 135, 50, 20)];
    [m_YTDEPLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_YTDEPLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_YTDEPLabel.backgroundColor=[UIColor clearColor];
    m_YTDEPLabel.text=@"26,961";
    [self addSubview:m_YTDEPLabel];
    
    m_DNILevelLabel=[[UILabel alloc]initWithFrame:CGRectMake(210, 123, 50, 20)];
    [m_DNILevelLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_DNILevelLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_DNILevelLabel.backgroundColor=[UIColor clearColor];
    m_DNILevelLabel.text=@"600";
    [self addSubview:m_DNILevelLabel];
    
    m_AlertImageView=[[UIImageView alloc]initWithFrame:CGRectMake(158, 37, 8, 8)];
    m_AlertImageView.backgroundColor=[UIColor clearColor];
    m_AlertImageView.image=[UIImage imageNamed:@"Alert-Green.png"];
    [self addSubview:m_AlertImageView];
    
    m_WheatherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(142, 16, 20, 20)];
    m_WheatherImageView.image=[UIImage imageNamed:@"Sun-icon.png"];
    [self addSubview:m_WheatherImageView];
    
    UIImageView *m_PowerDialImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 33, 131, 93)];
    m_PowerDialImageView.image=[UIImage imageNamed:@"BigDial.png"];
    [self addSubview:m_PowerDialImageView];
    
    UILabel *kwLabel=[[UILabel alloc]initWithFrame:CGRectMake(55,78,20,10)];
    kwLabel.text=@"kW";
    kwLabel.font=[UIFont fontWithName:@"Arial" size:10];
    kwLabel.backgroundColor=[UIColor clearColor];
    kwLabel.textAlignment=UITextAlignmentCenter;
    kwLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    [m_PowerDialImageView addSubview:kwLabel];
    
    m_ValueLabel1=[[UILabel alloc]initWithFrame:CGRectMake(6, 72, 23, 93)]; // 0 72 23 93
    [m_ValueLabel1 setFont:[UIFont fontWithName:@"Arial" size:16]];
    m_ValueLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel1.backgroundColor=[UIColor clearColor];
    m_ValueLabel1.textAlignment=UITextAlignmentRight;
    m_ValueLabel1.text=@"0";
    [self addSubview:m_ValueLabel1];
    
    m_ValueLabel2=[[UILabel alloc]initWithFrame:CGRectMake(11, 20, 28, 93)]; // 8 20 28 93
    [m_ValueLabel2 setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_ValueLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel2.backgroundColor=[UIColor clearColor];
//    m_ValueLabel2.strokeColor=[UIColor blackColor];
    m_ValueLabel2.textAlignment=UITextAlignmentRight;
    m_ValueLabel2.text=@"8";
    [self addSubview:m_ValueLabel2];
    
    m_ValueLabel3=[[UILabel alloc]initWithFrame:CGRectMake(60, -2, 30, 93)]; // 61 -6 30 93
    [m_ValueLabel3 setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_ValueLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
//    m_ValueLabel3.strokeColor=[UIColor blackColor];
    m_ValueLabel3.backgroundColor=[UIColor clearColor];
    m_ValueLabel3.textAlignment=UITextAlignmentCenter;
    m_ValueLabel3.text=@"16";
    [self addSubview:m_ValueLabel3];
    
    m_ValueLabel4=[[UILabel alloc]initWithFrame:CGRectMake(111, 20, 30, 93)]; // 113 20 30 93
    [m_ValueLabel4 setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_ValueLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel4.backgroundColor=[UIColor clearColor];
    m_ValueLabel4.textAlignment=UITextAlignmentLeft;
    m_ValueLabel4.text=@"24";
    [self addSubview:m_ValueLabel4];
    
    m_ValueLabel5=[[UILabel alloc]initWithFrame:CGRectMake(111, 72, 30, 93)]; // 118 72 30 93
    [m_ValueLabel5 setFont:[UIFont fontWithName:@"Arial" size:10]];
    m_ValueLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel5.backgroundColor=[UIColor clearColor];
    m_ValueLabel5.textAlignment=UITextAlignmentCenter;
    m_ValueLabel5.text=@"32";
    [self addSubview:m_ValueLabel5];
    
    m_PowerNeedleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(60+10, 0+33, 11, 131)]; // 60+10 0+33 11 131
    m_PowerNeedleImageView.image=[UIImage imageNamed:@"BIgNeedle1.png"];
    [self addSubview:m_PowerNeedleImageView];
    
    [m_PowerNeedleImageView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
    UIImageView *m_DNIDialImageView=[[UIImageView alloc]initWithFrame:CGRectMake(153, 50, 108, 76)];
    m_DNIDialImageView.image=[UIImage imageNamed:@"SmallDial.png"];
    [self addSubview:m_DNIDialImageView];
    
    UILabel *pLabel1=[[UILabel alloc]initWithFrame:CGRectMake(165, 74, 131, 93)]; // 160 72 131 93
    [pLabel1 setFont:[UIFont fontWithName:@"Arial" size:8]];
    pLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel1.backgroundColor=[UIColor clearColor];
    pLabel1.text=@"0";
    [self addSubview:pLabel1];
    
    UILabel *pLabel2=[[UILabel alloc]initWithFrame:CGRectMake(163, 33, 131, 93)]; // 162 31 131 93
    [pLabel2 setFont:[UIFont fontWithName:@"Arial" size:8]];
    pLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel2.backgroundColor=[UIColor clearColor];
    pLabel2.text=@"300";
    [self addSubview:pLabel2];
    
    UILabel *pLabel3=[[UILabel alloc]initWithFrame:CGRectMake(200, 13, 131, 93)]; // 202 12 131 93
    [pLabel3 setFont:[UIFont fontWithName:@"Arial" size:8]];
    pLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel3.backgroundColor=[UIColor clearColor];
    pLabel3.text=@"600";
    [self addSubview:pLabel3];
    
    UILabel *pLabel4=[[UILabel alloc]initWithFrame:CGRectMake(238, 33, 131, 93)]; // 240 33 131 93
    [pLabel4 setFont:[UIFont fontWithName:@"Arial" size:8]];
    pLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel4.backgroundColor=[UIColor clearColor];
    pLabel4.text=@"900";
    [self addSubview:pLabel4];
    
    UILabel *pLabel5=[[UILabel alloc]initWithFrame:CGRectMake(239, 74, 131, 93)]; // 240 72 131 93
    [pLabel5 setFont:[UIFont fontWithName:@"Arial" size:8]];
    pLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pLabel5.backgroundColor=[UIColor clearColor];
    pLabel5.text=@"1200";
    [self addSubview:pLabel5];
    
    m_DNINeedleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(49+153, -.5+50, 10, 109)];
    m_DNINeedleImageView.image=[UIImage imageNamed:@"SmallNeedle1.png"];
    [self addSubview:m_DNINeedleImageView];
    
    [m_DNINeedleImageView setTransform:CGAffineTransformMakeRotation(110*0.0174532925)];      
    
  }
  return self;
}
-(void)dealloc
{
  //printf("Dealloc in SiteListTileView\n");
}
#pragma mark -- Methods to fill data for UI Elements
-(void)setSiteName:(NSString*)value
{
  m_SiteNameLabel.text=value;
}
-(void)setSiteLocation:(NSString*)value
{
  m_SiteLocationLabel.text=value;
}
-(void)setSiteTime:(NSString*)value
{
  m_SiteTimeLabel.text=value;
}
-(void)setSiteWeatherDescription:(NSString*)value
{
  m_SiteWeatherDescLabel.text=value;
}
-(void)setSiteTemperature:(NSString*)value
{
  m_SiteTempLabel.text=value;
}
-(void)setSiteTodayEP:(NSString*)value
{
  m_TodayEPLabel.text=value;
}
-(void)setSiteYesterdayEP:(NSString*)value
{
  m_YTDEPLabel.text=value;
}
-(void)setSiteDNILevel:(NSString*)value
{
  m_DNILevelLabel.text=value;
}
-(void)setSiteValue1:(NSString*)value
{
  m_ValueLabel1.text=value;
}
-(void)setSiteValue2:(NSString*)value
{
  m_ValueLabel2.text=value;
}
-(void)setSiteValue3:(NSString*)value
{
  m_ValueLabel3.text=value;
}
-(void)setSiteValue4:(NSString*)value
{
  m_ValueLabel4.text=value;
}
-(void)setSiteValue5:(NSString*)value
{
  m_ValueLabel5.text=value;
}
-(void)setSiteAlertImageName:(NSString*)value
{
  m_AlertImageView.image=[UIImage imageNamed:value];
}
-(void)setSiteWeatherImageName:(NSString*)value
{
  m_WheatherImageView.image=[UIImage imageNamed:value];
}
-(void)setPowerNeedleRotationAngle:(float)angle
{
  [m_PowerNeedleImageView setTransform:CGAffineTransformMakeRotation(angle)];
}
-(void)setDNINeedleRotationAngle:(float)angle
{
  [m_DNINeedleImageView setTransform:CGAffineTransformMakeRotation(angle)];
}
-(void)decreasePowerLabelSize:(int)max {
  int s = max > 99 ? 9 : 10;
  [m_ValueLabel1 setFont:[UIFont fontWithName:@"Arial" size:s]];
  [m_ValueLabel2 setFont:[UIFont fontWithName:@"Arial" size:s]];
  [m_ValueLabel3 setFont:[UIFont fontWithName:@"Arial" size:s]];
  [m_ValueLabel4 setFont:[UIFont fontWithName:@"Arial" size:s]];
  [m_ValueLabel5 setFont:[UIFont fontWithName:@"Arial" size:s]];
}
@end

