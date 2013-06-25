//
//  MiniEachTileView.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MiniEachTileView.h"

@implementation MiniEachTileView
- (void)drawObjects:(CGRect)frame {
    frame.origin.x=0.0;
    frame.origin.y=0.0;
    
    UIImageView *m_BackgroundImageView=[[UIImageView alloc]initWithFrame:frame];
    m_BackgroundImageView.image=[UIImage imageNamed:@"SingleTileBG.png"];
    [self addSubview:m_BackgroundImageView];
    
    m_TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(4, 4, 74, 7)];
    m_TitleLabel.text=@"Phase1";
    m_TitleLabel.textColor=[UIColor whiteColor];
    [m_TitleLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    m_TitleLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:m_TitleLabel];
    
    
    UIImageView *m_DialImageView=[[UIImageView alloc]initWithFrame:CGRectMake(7, 11, 77, 54)];
    m_DialImageView.image=[UIImage imageNamed:@"SingleDial.png"];
    [self addSubview:m_DialImageView];
    
    UILabel *kwLabel=[[UILabel alloc]initWithFrame:CGRectMake(31,44,15,7)];
    kwLabel.text=@"kW";
    kwLabel.font=[UIFont fontWithName:@"Arial" size:6];
    kwLabel.backgroundColor=[UIColor clearColor];
    kwLabel.textAlignment=UITextAlignmentCenter;
    kwLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    [m_DialImageView addSubview:kwLabel];
    
    m_ValueLabel1=[[UILabel alloc]initWithFrame:CGRectMake(-4, 26, 22, 69)]; // -6 35 30 93
    [m_ValueLabel1 setFont:[UIFont fontWithName:@"Arial" size:6]]; // 6
    m_ValueLabel1.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0]; // 87.1 89
    m_ValueLabel1.backgroundColor=[UIColor clearColor];
    m_ValueLabel1.textAlignment=UITextAlignmentRight;
    m_ValueLabel1.text=@"0";
    [self addSubview:m_ValueLabel1];
    
    m_ValueLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, -13, 22, 93)]; // 0 -4 30 93
    [m_ValueLabel2 setFont:[UIFont fontWithName:@"Arial" size:6]];
    m_ValueLabel2.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel2.backgroundColor=[UIColor clearColor];
    m_ValueLabel2.textAlignment=UITextAlignmentRight;
    m_ValueLabel2.text=@"8";
    [self addSubview:m_ValueLabel2];
    
    m_ValueLabel3=[[UILabel alloc]initWithFrame:CGRectMake(35,-28, 22, 93)]; // 47 -22 30 93
    [m_ValueLabel3 setFont:[UIFont fontWithName:@"Arial" size:6]];
    m_ValueLabel3.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel3.backgroundColor=[UIColor clearColor];
    m_ValueLabel3.textAlignment=UITextAlignmentCenter;
    m_ValueLabel3.text=@"16";
    [self addSubview:m_ValueLabel3];
    
    m_ValueLabel4=[[UILabel alloc]initWithFrame:CGRectMake(68, -13, 22, 93)]; // 92 -4 30 93
    [m_ValueLabel4 setFont:[UIFont fontWithName:@"Arial" size:6]];
    m_ValueLabel4.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel4.backgroundColor=[UIColor clearColor];
    m_ValueLabel4.textAlignment=UITextAlignmentLeft;
    m_ValueLabel4.text=@"24";
    [self addSubview:m_ValueLabel4];
    
    m_ValueLabel5=[[UILabel alloc]initWithFrame:CGRectMake(72, 14, 22, 93)]; // 100 34 30 93
    [m_ValueLabel5 setFont:[UIFont fontWithName:@"Arial" size:6]];
    m_ValueLabel5.textColor=[UIColor colorWithRed:(95.1/100.0) green:(97.0/100.0) blue:(0.0/100.0) alpha:1.0];
    m_ValueLabel5.backgroundColor=[UIColor clearColor];
    m_ValueLabel5.textAlignment=UITextAlignmentLeft;
    m_ValueLabel5.text=@"32";
    [self addSubview:m_ValueLabel5];
    
    m_NeedleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(41, 10, 8, 79)];
    m_NeedleImageView.image=[UIImage imageNamed:@"SingleNeedle.png"];
    [self addSubview:m_NeedleImageView];
    
    m_AlertImageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 4, 6, 6)];
    m_AlertImageView.image=[UIImage imageNamed:@"Alert-Green.png"];
    [self addSubview:m_AlertImageView];
    
    /*
    UILabel *pTodayKWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(21, 45, 97, 69)];
    [pTodayKWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
    pTodayKWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pTodayKWHTitleLabel.backgroundColor=[UIColor clearColor];
    pTodayKWHTitleLabel.text=@"Today kWh";
    [self addSubview:pTodayKWHTitleLabel];   
    
    UILabel *pTodayKWHSeperator = [[UILabel alloc]initWithFrame:CGRectMake(48, 45, 97, 69)];
    [pTodayKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:6.5]];
    pTodayKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pTodayKWHSeperator.backgroundColor=[UIColor clearColor];
    pTodayKWHSeperator.text=@"|";
    [self addSubview:pTodayKWHSeperator];
    */
    
    m_TodayKWHValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(52, 45, 97, 69)]; // 70 47 131 93
    [m_TodayKWHValueLabel setFont:[UIFont fontWithName:@"Arial" size:6.5]];
    m_TodayKWHValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_TodayKWHValueLabel.backgroundColor=[UIColor clearColor];
    m_TodayKWHValueLabel.text=@"1915";
    
    //[self addSubview:m_TodayKWHValueLabel];
    
    UILabel *pYTDKWHTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 37, 97, 69)];
    [pYTDKWHTitleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pYTDKWHTitleLabel.textColor=[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0];
    pYTDKWHTitleLabel.backgroundColor=[UIColor clearColor];
    pYTDKWHTitleLabel.text=@"Power kW";
    [self addSubview:pYTDKWHTitleLabel];      
    
    UILabel *pYTDKWHSeperator = [[UILabel alloc]initWithFrame:CGRectMake(56, 37, 97, 69)];
    [pYTDKWHSeperator setFont:[UIFont fontWithName:@"Arial-BoldMT" size:7]];
    pYTDKWHSeperator.textColor=[UIColor colorWithRed:(33.3/100.0) green:(33.3/100.0) blue:(33.3/100.0) alpha:1.0];
    pYTDKWHSeperator.backgroundColor=[UIColor clearColor];
    pYTDKWHSeperator.text=@"|";
    [self addSubview:pYTDKWHSeperator];  
    
    m_CurrentKWValueLabel=[[UILabel alloc]initWithFrame:CGRectMake(59, 37, 97, 69)]; // 70 55 131 93
    [m_CurrentKWValueLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    m_CurrentKWValueLabel.textColor=[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0];
    m_CurrentKWValueLabel.backgroundColor=[UIColor clearColor];
    m_CurrentKWValueLabel.text=@"13802";
    [self addSubview:m_CurrentKWValueLabel];
    
    UIButton *m_Button=[UIButton buttonWithType:UIButtonTypeCustom];
    m_Button.frame=frame;
    [m_Button addTarget:self action:@selector(tileClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_Button];
}
@end
