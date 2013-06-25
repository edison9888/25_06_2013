//
//  PowerVsDNIScrollView.m
//  GreenVolts
//
//  Created by YML on 9/13/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "PowerVsDNIScrollView.h"


@implementation PowerVsDNIScrollView

-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if(self)
  {
    frame.size.height-=35;
    
    m_ScrollView=[[UIScrollView alloc]initWithFrame:frame];
    [m_ScrollView delaysContentTouches];
    m_ScrollView.clipsToBounds=YES;
    m_ScrollView.delegate=self;
    m_ScrollView.showsHorizontalScrollIndicator=NO;
    m_ScrollView.showsVerticalScrollIndicator=NO;
    m_ScrollView.contentMode = (UIViewContentModeScaleAspectFit);
    m_ScrollView.contentSize=CGSizeMake(frame.size.width, frame.size.height);
    m_ScrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    m_ScrollView.maximumZoomScale=4.0;
    m_ScrollView.minimumZoomScale=1.0;
    [self addSubview:m_ScrollView];      
    
    m_DayLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 212, 130, 10)];
    m_DayLabel.textColor=[UIColor whiteColor];
    m_DayLabel.textAlignment=UITextAlignmentRight;
    m_DayLabel.backgroundColor=[UIColor clearColor];
    [m_DayLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    [self addSubview:m_DayLabel];
    
    m_PowerVsDNIView=[[PowerVsDNIView alloc]initWithFrame:frame];
    [m_ScrollView addSubview:m_PowerVsDNIView]; 
  }
  return self;
}

-(void)dealloc
{
  //printf("Dealloc in PowerVsDNIScrollView\n");
  [m_PowerVsDNIView removeFromSuperview];
  m_PowerVsDNIView=nil;
  [m_ScrollView removeFromSuperview];
  m_ScrollView=nil;
}
#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
  return [scrollView.subviews objectAtIndex:0];
}

-(void)fillValuesFrom:(NSArray*)pArray andArrayCount:(int)count
{
  NSDate *pEnddate=[[NSUserDefaults standardUserDefaults]objectForKey:kCurrentSelectedDateKey];
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [dateFormat setDateFormat:@"EEEE, MMMM d, YYYY"];
  NSString *pDateString= [dateFormat stringFromDate:pEnddate];
  m_DayLabel.text=pDateString;
  
  CGRect frame=self.frame;
  frame.size.height-=35;
  [m_PowerVsDNIView fillValuesFrom:pArray withArrayCount:count];
   
}

@end
