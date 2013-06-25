//
//  WindScrollView.m
//  GreenVolts
//
//  Created by YML on 9/14/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "WindScrollView.h"


@implementation WindScrollView

@synthesize m_delegate;
-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if (self)
  {
    frame.size.height-=35;
    UIScrollView *m_ScrollView=[[UIScrollView alloc]initWithFrame:frame];
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSDate *pEnddate=[[NSUserDefaults standardUserDefaults]objectForKey:kCurrentSelectedDateKey];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormat setDateFormat:@"EEEE, MMMM d, YYYY"];
    NSString *pDateString= [dateFormat stringFromDate:pEnddate];  
    
    m_DayLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 213, 130, 10)];
    m_DayLabel.text=pDateString;
    m_DayLabel.textColor=[UIColor whiteColor];
    m_DayLabel.textAlignment=UITextAlignmentRight;
    m_DayLabel.backgroundColor=[UIColor clearColor];
    [m_DayLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
    [self addSubview:m_DayLabel];
    
    m_WindView=[[WindView alloc]initWithFrame:frame];
    m_WindView.m_deleagte=self;
    [m_ScrollView addSubview:m_WindView];
  }
  return self;
}

-(void)dealloc
{
  //printf("Dealloc in WindScrollView\n");
  [m_WindView removeFromSuperview];
  m_WindView=nil;
}

-(void)fillValuesFrom:(NSArray *)values
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"MM-dd-yyyy"];
  
  NSDate *pEnddate=[[NSUserDefaults standardUserDefaults]objectForKey:kCurrentSelectedDateKey];
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
  [dateFormat setDateFormat:@"EEEE, MMMM d, YYYY"];
  NSString *pDateString= [dateFormat stringFromDate:pEnddate]; 
  m_DayLabel.text=pDateString;
  
  [m_WindView drawGraphFromValues:values];
}

#pragma mark WindViewDelegate Methods
-(void)fetchSessionTokenforWind
{
  if(m_delegate && [m_delegate respondsToSelector:@selector(fetchSessionTokenforWindScrollView)])
    [m_delegate fetchSessionTokenforWindScrollView];
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
  return [scrollView.subviews objectAtIndex:0];
}
@end
