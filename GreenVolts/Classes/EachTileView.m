//
//  EachTileView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "EachTileView.h"

@interface EachTileView(PVT)
-(void)tileClicked;
@end

@implementation EachTileView
@synthesize m_Index,m_delegate;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) 
  {
      [self drawObjects:frame];
  }
  return self;
}

-(void)drawObjects:(CGRect)frame {
  frame.origin.x=0.0;
  frame.origin.y=0.0;
    
  UIImageView *m_BackgroundImageView=[[UIImageView alloc]initWithFrame:frame];
  m_BackgroundImageView.image=[UIImage imageNamed:@"SingleTileBG.png"];
  [self addSubview:m_BackgroundImageView];
  
  m_TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 3, 100, 10)];
  m_TitleLabel.text=@"Phase1";
  m_TitleLabel.textColor=[UIColor whiteColor];
  [m_TitleLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
  m_TitleLabel.backgroundColor=[UIColor clearColor];
  [self addSubview:m_TitleLabel];
    
  UIImageView *m_DialImageView=[[UIImageView alloc]initWithFrame:CGRectMake(9, 15, 104, 73)];
  m_DialImageView.image=[UIImage imageNamed:@"SingleDial.png"];
  [self addSubview:m_DialImageView];
    
  UILabel *kwLabel=[[UILabel alloc]initWithFrame:CGRectMake(42,60,20,10)];
  kwLabel.text=@"kW";
  kwLabel.font=[UIFont fontWithName:@"Arial" size:8];
  kwLabel.backgroundColor=[UIColor clearColor];
  kwLabel.textAlignment=UITextAlignmentCenter;
  kwLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
  [m_DialImageView addSubview:kwLabel];
    
  m_ValueLabel1=[[UILabel alloc]initWithFrame:CGRectMake(-6, 35, 30, 93)]; // -6 35 30 93
  [m_ValueLabel1 setFont:[UIFont fontWithName:@"Arial" size:8]]; // 6
  m_ValueLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0]; // 87.1 89
  m_ValueLabel1.backgroundColor=[UIColor clearColor];
  m_ValueLabel1.textAlignment=UITextAlignmentRight;
  m_ValueLabel1.text=@"0";
  [self addSubview:m_ValueLabel1];
    
  m_ValueLabel2=[[UILabel alloc]initWithFrame:CGRectMake(-2, -4, 30, 93)]; // 0 -4 30 93
  [m_ValueLabel2 setFont:[UIFont fontWithName:@"Arial" size:8]];
  m_ValueLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
  m_ValueLabel2.backgroundColor=[UIColor clearColor];
  m_ValueLabel2.textAlignment=UITextAlignmentRight;
  m_ValueLabel2.text=@"8";
  [self addSubview:m_ValueLabel2];
    
  m_ValueLabel3=[[UILabel alloc]initWithFrame:CGRectMake(46,-22, 30, 93)]; // 47 -22 30 93
  [m_ValueLabel3 setFont:[UIFont fontWithName:@"Arial" size:8]];
  m_ValueLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
  m_ValueLabel3.backgroundColor=[UIColor clearColor];
  m_ValueLabel3.textAlignment=UITextAlignmentCenter;
  m_ValueLabel3.text=@"16";
  [self addSubview:m_ValueLabel3];
    
  m_ValueLabel4=[[UILabel alloc]initWithFrame:CGRectMake(90, -4, 30, 93)]; // 92 -4 30 93
  [m_ValueLabel4 setFont:[UIFont fontWithName:@"Arial" size:8]];
  m_ValueLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
  m_ValueLabel4.backgroundColor=[UIColor clearColor];
  m_ValueLabel4.textAlignment=UITextAlignmentLeft;
  m_ValueLabel4.text=@"24";
  [self addSubview:m_ValueLabel4];
    
  m_ValueLabel5=[[UILabel alloc]initWithFrame:CGRectMake(95, 35, 30, 93)]; // 100 34 30 93
  [m_ValueLabel5 setFont:[UIFont fontWithName:@"Arial" size:8]];
  m_ValueLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
  m_ValueLabel5.backgroundColor=[UIColor clearColor];
  m_ValueLabel5.textAlignment=UITextAlignmentLeft;
  m_ValueLabel5.text=@"32";
  [self addSubview:m_ValueLabel5];
    
  m_NeedleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(47+9, -1+15, 10,107)];
  m_NeedleImageView.image=[UIImage imageNamed:@"SingleNeedle.png"];
  [self addSubview:m_NeedleImageView];
  
  m_AlertImageView=[[UIImageView alloc]initWithFrame:CGRectMake(108, 6, 8, 8)];
  m_AlertImageView.image=[UIImage imageNamed:@"Alert-Green.png"];
  [self addSubview:m_AlertImageView];
    
  UILabel *pTodayKWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(28, 55, 131, 93)];
  [pTodayKWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
  pTodayKWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
  pTodayKWHTitleLabel.backgroundColor=[UIColor clearColor];
  pTodayKWHTitleLabel.text=@"Today kWh";
  [self addSubview:pTodayKWHTitleLabel];   
  
  UILabel *pTodayKWHSeperator = [[UILabel alloc]initWithFrame:CGRectMake(65, 55, 131, 93)];
  [pTodayKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
  pTodayKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
  pTodayKWHSeperator.backgroundColor=[UIColor clearColor];
  pTodayKWHSeperator.text=@"|";
  [self addSubview:pTodayKWHSeperator];
    
  m_TodayKWHValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 55, 131, 93)]; // 70 47 131 93
  [m_TodayKWHValueLabel setFont:[UIFont fontWithName:@"Arial" size:6.5]];
  m_TodayKWHValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
  m_TodayKWHValueLabel.backgroundColor=[UIColor clearColor];
  m_TodayKWHValueLabel.text=@"1915";
  [self addSubview:m_TodayKWHValueLabel];
  
  UILabel *pYTDKWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(31, 47, 131, 93)];
  [pYTDKWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
  pYTDKWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
  pYTDKWHTitleLabel.backgroundColor=[UIColor clearColor];
  pYTDKWHTitleLabel.text=@"Power kW";
  [self addSubview:pYTDKWHTitleLabel];      
  
  UILabel *pYTDKWHSeperator = [[UILabel alloc]initWithFrame:CGRectMake(65, 47, 131, 93)];
  [pYTDKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
  pYTDKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
  pYTDKWHSeperator.backgroundColor=[UIColor clearColor];
  pYTDKWHSeperator.text=@"|";
  [self addSubview:pYTDKWHSeperator];  
    
  m_CurrentKWValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 47, 131, 93)]; // 70 55 131 93
  [m_CurrentKWValueLabel setFont:[UIFont fontWithName:@"Arial" size:6.5]];
  m_CurrentKWValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
  m_CurrentKWValueLabel.backgroundColor=[UIColor clearColor];
  m_CurrentKWValueLabel.text=@"13802";
  [self addSubview:m_CurrentKWValueLabel];
  
  UIButton *m_Button=[UIButton buttonWithType:UIButtonTypeCustom];
  m_Button.frame=frame;
  [m_Button addTarget:self action:@selector(tileClicked) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:m_Button];
}

-(void)tileClicked {
  if(m_delegate && [m_delegate respondsToSelector:@selector(TileClicked:)])
    [m_delegate TileClicked:self];
}

- (void)dealloc 
{
  m_delegate=nil;
  //printf("Dealloc in EachTileView\n");
}
#pragma mark -- UI update methods
-(void)setEachTileTitle:(NSString*)value
{
  m_TitleLabel.text=value;
}
-(void)setEachTileTodayKWH:(NSString*)value
{
  m_TodayKWHValueLabel.text=value;
}
-(void)setEachTileCurrentKW:(NSString *)value
{
  m_CurrentKWValueLabel.text= value == nil ? @"" : [NSString stringWithFormat:@"%.1f", [value floatValue]];
}
-(void)setEachTileValue1:(NSString*)value
{
  m_ValueLabel1.text=value;
}
-(void)setEachTileValue2:(NSString*)value
{
  m_ValueLabel2.text=value;
}
-(void)setEachTileValue3:(NSString*)value
{
  m_ValueLabel3.text=value;
}
-(void)setEachTileValue4:(NSString*)value
{
  m_ValueLabel4.text=value;
}
-(void)setEachTileValue5:(NSString*)value
{
  m_ValueLabel5.text=value;
}
-(void)setEachTileNeedleRotationAngle:(float)angle
{
  [m_NeedleImageView setTransform:CGAffineTransformMakeRotation(angle)];
}
-(void)setEachTileAlertImageName:(NSString*)value
{
  m_AlertImageView.image=[UIImage imageNamed:value];
}
@end
