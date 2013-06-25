//
//  PowerVsDNIView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "PowerVsDNIView.h"
#import "DrawGraphView.h"

@interface PowerVsDNIView(PVT)
-(void)fillLeftYAxis;
-(void)fillRightYAxis;
-(void)fillXAxis;
@end

@implementation PowerVsDNIView

-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if(self)
  {
    UIView *leftindicatorImageView=[[UIView alloc]initWithFrame:CGRectMake(0, 107, 8, 8)];
    [leftindicatorImageView setBackgroundColor:[UIColor colorWithRed:0.0 green:(62.4/100.0) blue:(2.4/100.0) alpha:1.0]];
    [self addSubview:leftindicatorImageView];
    
    UILabel *leftgraphTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(-15, 82, 40, 12)];
    leftgraphTitleLabel.text=@"Power (kW)";
    leftgraphTitleLabel.textColor=[UIColor whiteColor];
    leftgraphTitleLabel.textAlignment=UITextAlignmentRight;
    leftgraphTitleLabel.backgroundColor=[UIColor clearColor];
    leftgraphTitleLabel.transform=CGAffineTransformMakeRotation((M_PI*3)/2);
    [leftgraphTitleLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    [self addSubview:leftgraphTitleLabel];
    
    UIView *rightindicatorImageView=[[UIView alloc]initWithFrame:CGRectMake(286, 107, 8, 8)];
    [rightindicatorImageView setBackgroundColor:[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0]];
    [self addSubview:rightindicatorImageView];
    
    UILabel *rightgraphTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(270, 82, 40, 12)];
    rightgraphTitleLabel.text=@"DNI (W/m²)";
    rightgraphTitleLabel.textColor=[UIColor whiteColor];
    rightgraphTitleLabel.textAlignment=UITextAlignmentRight;
    rightgraphTitleLabel.backgroundColor=[UIColor clearColor];
    rightgraphTitleLabel.transform=CGAffineTransformMakeRotation((M_PI*3)/2);
    [rightgraphTitleLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    [self addSubview:rightgraphTitleLabel];
        
    //printf("\nValues sent from PowerVsDNIView to DrawGraphView\n%s\n",[[m_ResultArray description] UTF8String]);
    CGPoint origin=frame.origin;
    origin.y-=8;
    frame.origin=origin;
    pDrawGraphView=[[DrawGraphView alloc]initWithFrame:frame];
    [self addSubview:pDrawGraphView];
  }
  return self;
}
-(void)dealloc
{
  //printf("Dealloc in PowerVsDNIView\n");
  [pDrawGraphView removeFromSuperview];
  pDrawGraphView=nil;
}

-(void)fillValuesFrom:(NSArray*)pArray withArrayCount:(int)count
{
  NSString *pString=[[NSUserDefaults standardUserDefaults]objectForKey:@"ENTITY_TYPE"];
  int Entity=[pString intValue];
  int MaximumYValue=0;
  if(Entity==2)
    MaximumYValue=count*16;
  else if(Entity==3)
    MaximumYValue=count*16;
  else if(Entity==4)
    MaximumYValue=16;
  else if(Entity==5)
    MaximumYValue=8;
  
  range=ceil(MaximumYValue/8);
  for (UIView *view in self.subviews)
  {
    if (view.tag==888)
    {
      [view removeFromSuperview];
    }
  }
  [self fillLeftYAxis];
  [self fillRightYAxis];
  [self fillXAxis];
  [self bringSubviewToFront:pDrawGraphView];
  [pDrawGraphView drawGraphWithArray:pArray andArrayCount:count];
}
-(void)fillLeftYAxis
{
  for(int i=0;i<=8;i++)
  {
    UILabel *pYAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 184-(i*23), 15, 8)];
    int val=i*range;
    ////printf("\n%d\n",val);
    pYAxisLabel.text=[NSString stringWithFormat:@"%d",val];
    pYAxisLabel.textColor=[UIColor whiteColor];
    pYAxisLabel.backgroundColor=[UIColor clearColor];
    pYAxisLabel.textAlignment=UITextAlignmentRight;
    [pYAxisLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    pYAxisLabel.adjustsFontSizeToFitWidth=YES;
    pYAxisLabel.tag=888;
    [self addSubview:pYAxisLabel];
    
    UIImageView *pImageView=[[UIImageView alloc]initWithFrame:CGRectMake(24, 188-(i*23), 246, 2)];
    pImageView.image=[UIImage imageNamed:@"HorizontalLine.png"];
    pImageView.tag=888;
    [self addSubview:pImageView];
  }  
}

-(void)fillRightYAxis
{
  for(int i=0;i<=8;i++)
  {
    UILabel *pYAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(271, 185-(i*23), 15, 8)];
    pYAxisLabel.text=[NSString stringWithFormat:@"%d",i*150];
    pYAxisLabel.textColor=[UIColor whiteColor];
    pYAxisLabel.backgroundColor=[UIColor clearColor];
    pYAxisLabel.textAlignment=UITextAlignmentLeft;
    [pYAxisLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    pYAxisLabel.tag=888;
    [self addSubview:pYAxisLabel];
  }    
}

-(void)fillXAxis
{
  NSArray *m_XValueArray=[NSArray arrayWithObjects:@"4 AM",@"5 AM",@"6 AM",@"7 AM",@"8 AM",@"9 AM",@"10 AM",@"11 AM",@"12 AM",
                 @"1 PM",@"2 PM",@"3 PM",@"4 PM",@"5 PM",@"6 PM",@"7 PM",@"8 PM",@"9 PM",nil];
  for(int i=0;i<[m_XValueArray count];i++)
  {
    UILabel *pXAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(16+(i*14.5), 195, 20, 10)];
    NSString *text=[m_XValueArray objectAtIndex:i];
    pXAxisLabel.text=text;
    pXAxisLabel.textColor=[UIColor whiteColor];
    pXAxisLabel.backgroundColor=[UIColor clearColor];
    pXAxisLabel.textAlignment=UITextAlignmentLeft;
    pXAxisLabel.transform=CGAffineTransformMakeRotation(M_PI/3);
    [pXAxisLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    pXAxisLabel.tag=888;
    [self addSubview:pXAxisLabel];
    
    UIImageView *pImageView=[[UIImageView alloc]initWithFrame:CGRectMake(23+(i*14.5), 4, 1.5, 185)];
    pImageView.image=[UIImage imageNamed:@"VerticalLine.png"];
    pImageView.tag=888;
    [self addSubview:pImageView];
  }
}


@end
