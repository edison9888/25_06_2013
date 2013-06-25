//
//  TotalEnergyView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "TotalEnergyView.h"
#import <QuartzCore/QuartzCore.h>
#import "EntityDetails.h"
#import "DateTimeConverter.h"
@interface TotalEnergyView(PVT)<UIScrollViewDelegate>
-(void)fillYAxis;
-(void)fillXAxis;
-(void)drawBarGraph;
@end

@implementation TotalEnergyView
@synthesize m_delegate;
-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if(self)
  {
    UIView *indicatorView=[[UIView alloc]initWithFrame:CGRectMake(5, 114, 8, 8)];
    [indicatorView setBackgroundColor:[UIColor colorWithRed:0.0 green:(62.4/100.0) blue:(2.4/100.0) alpha:1.0]];
    [self addSubview:indicatorView];
    
    UILabel *graphTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(-11, 87, 40, 12)];
    graphTitleLabel.text=@"Energy (kWh)";
    graphTitleLabel.textColor=[UIColor whiteColor];
    graphTitleLabel.textAlignment=UITextAlignmentRight;
    graphTitleLabel.backgroundColor=[UIColor clearColor];
    graphTitleLabel.transform=CGAffineTransformMakeRotation((M_PI*3)/2);
    [graphTitleLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    [self addSubview:graphTitleLabel];
    
    UILabel *pCenterLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, 15, 7)];
    pCenterLabel.text=@"0";
    pCenterLabel.textColor=[UIColor whiteColor];
    pCenterLabel.textAlignment=UITextAlignmentRight;
    pCenterLabel.backgroundColor=[UIColor clearColor];
    [pCenterLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    [self addSubview:pCenterLabel];
  }
  return self;
}

-(void)drawGraphFromValues:(NSArray*)values
{
  if(m_ResultArray)
    m_ResultArray=nil;
  m_ResultArray=[NSArray arrayWithArray:values];
  
  EntityDetails *pEntityDetails=[m_ResultArray objectAtIndex:0];
  MaximumYValue=[pEntityDetails.m_Energy floatValue];
  for(int i=0;i<[m_ResultArray count];i++)
  {
    EntityDetails *pEntityDetails=[m_ResultArray objectAtIndex:i];
    float curVal=[pEntityDetails.m_Energy floatValue];
    if(curVal>MaximumYValue)
      MaximumYValue=curVal;
  }      
  float maxfloat=MaximumYValue+10;
  range=ceil(maxfloat/14);
  for (UIView *view in self.subviews) 
  {
    if(view.tag==888)
    {
      [view removeFromSuperview];
    }
  }
  [self fillYAxis];
  [self fillXAxis];
  [self drawBarGraph];
}
#pragma mark UIScrollView delegate methods
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if(scrollView.contentOffset.x<=-50.0)
    if(m_delegate && [m_delegate respondsToSelector:@selector(leftSwipe)])
      [m_delegate leftSwipe];
    
  if(scrollView.contentOffset.x>=(scrollView.contentSize.width-254))
    if(m_delegate && [m_delegate respondsToSelector:@selector(rightSwipe)])
      [m_delegate rightSwipe];
}

-(void)fillYAxis
{
  for(int i=1;i<=14;i++)
  {
    UILabel *pYAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(13, 200-(i*14), 15, 7)];
    int val=i*range;
    ////printf("\n%d\n",val);
    pYAxisLabel.text=[NSString stringWithFormat:@"%d",val];
    pYAxisLabel.textColor=[UIColor whiteColor];
    pYAxisLabel.backgroundColor=[UIColor clearColor];
    pYAxisLabel.textAlignment=UITextAlignmentRight;
    [pYAxisLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    pYAxisLabel.adjustsFontSizeToFitWidth=YES;
    pYAxisLabel.tag=888;
    [self addSubview:pYAxisLabel];
  }  
}

-(void)fillXAxis
{
  int xOffset=0;
  if([m_ResultArray count]==6)
    xOffset=10;

  for(int i=1;i<=[m_ResultArray count];i++)
  {
    UILabel *pXAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(i*30)+((i-1)*8)+(i-1)*xOffset, 210, 20, 10)];
    
    EntityDetails *pEntityDetails=[m_ResultArray objectAtIndex:i-1];

    //epochTime: /Date(1320918970748-0800)/
    //epochTime: /Date(1320918970748)/
    NSString *actualTime=nil;
    NSString *str=[pEntityDetails.m_DateTimeLocal stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str1=[str1 stringByReplacingOccurrencesOfString:@")" withString:@""];
    str1=[str1 stringByReplacingOccurrencesOfString:@"Date" withString:@""];
    NSArray *pArr1=[str1 componentsSeparatedByString:@"-"];
    
    double seconds=0;
    double milliSeconds1=0;
    double seconds2beSubtracted=0;
    //If offset is provided
    if([pArr1 count]>=1)
    {
      NSString *date=[pArr1 objectAtIndex:0];
      milliSeconds1=[date doubleValue];
      seconds=milliSeconds1/1000;
      
      NSString *offset=[pArr1 objectAtIndex:1];
      NSString *hourOffset=[offset substringToIndex:2];
      NSString *minOffset=[offset substringFromIndex:2];
      seconds2beSubtracted=([hourOffset intValue]*3600)+([minOffset intValue]*60);
    }
    else
    {
      milliSeconds1=[str1 doubleValue];
      seconds=milliSeconds1/1000;
    }
    
    NSDate *pDate=[NSDate dateWithTimeIntervalSince1970:seconds-seconds2beSubtracted];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    [formatter setDateFormat:@"MM/dd"];
    
    //Optionally for time zone converstions    
    actualTime = [formatter stringFromDate:pDate];
    
    pXAxisLabel.text=[NSString stringWithFormat:@"%@",actualTime];

    pXAxisLabel.textColor=[UIColor whiteColor];
    pXAxisLabel.backgroundColor=[UIColor clearColor];
    pXAxisLabel.textAlignment=UITextAlignmentRight;
    pXAxisLabel.transform=CGAffineTransformMakeRotation(M_PI/3);
    [pXAxisLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    pXAxisLabel.tag=888;
    [self addSubview:pXAxisLabel];
  }
}

-(void)drawBarGraph
{
  int xOffset=0;
  if([m_ResultArray count]==6)
    xOffset=10;
  int MaximumHeight=194;
  for(int i=1;i<=[m_ResultArray count];i++)
  {
    EntityDetails *pEntityDetails=[m_ResultArray objectAtIndex:i-1];
    float val=[pEntityDetails.m_Energy floatValue];
    float maxVal=MaximumYValue+10;
    float ratio=val/maxVal;
    float height=ratio*MaximumHeight;
    
    float heightY=(205-height);
    
    UIView *pView=[[UIView alloc]initWithFrame:CGRectMake(30+(i-1)*8+(i-1)*30+(i-1)*xOffset, heightY, 30, height)];
    [pView setBackgroundColor:[UIColor colorWithRed:0.0 green:(62.4/100.0) blue:(2.4/100.0) alpha:1.0]];
    pView.tag=888;
    [self addSubview:pView];
//    m_ScrollView.contentSize=CGSizeMake(30+(i-1)*8+(i-1)*34, self.bounds.size.height);
  }
}

- (void)dealloc 
{
  m_delegate=nil;
  [m_ScrollView removeFromSuperview];
  m_ScrollView=nil;
  if(m_ResultArray){m_ResultArray=nil;}
  //printf("Dealloc in T.E view\n");
}


@end
