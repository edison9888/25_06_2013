//
//  DrawGraphView.m
//  GreenVolts
//
//  Created by YML on 9/14/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "DrawGraphView.h"
#import "EntityDetails.h"

@implementation DrawGraphView

-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if(self)
  {
    m_PowerArray=nil;
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}
-(void)dealloc
{
  //printf("Dealloc in DrawGraphView\n");
  m_PowerArray=nil;
}
-(void)drawGraphWithArray:(NSArray*)pArray andArrayCount:(int)count
{
  NSString *pString=[[NSUserDefaults standardUserDefaults]objectForKey:@"ENTITY_TYPE"];
  int Entity=[pString intValue];
  if(Entity==2)
    MaximumYValue=count*16;
  else if(Entity==3)
    MaximumYValue=count*16;
  else if(Entity==4)
    MaximumYValue=16;
  else if(Entity==5)
    MaximumYValue=8;
  if(m_PowerArray)
    m_PowerArray=nil;
  m_PowerArray=[NSArray arrayWithArray:pArray];
  [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect 
{
  if(!m_PowerArray)
    return;
  int MaximumHeight=184;            
  
  CGPoint initialPoint,finalPoint;
  for(int i=48;i<247;i++)
  {
    if(i+1<[m_PowerArray count])
    {
      EntityDetails *pEntityDetails1=[m_PowerArray objectAtIndex:i];
      if(pEntityDetails1.m_Power==nil)
      {
        //printf("Power is nil.  ");
        continue; 
      }
    float val1=[pEntityDetails1.m_Power floatValue];
    float maxVal1=MaximumYValue;
    float ratio1=val1/maxVal1;
    float height1=ratio1*MaximumHeight;
    
    float y1=(194-height1);
    float x1=(24+((i-48)*1.21));
    
    initialPoint=CGPointMake(x1, y1);
    
    EntityDetails *pEntityDetails2=[m_PowerArray objectAtIndex:i+1];
      if(pEntityDetails2.m_Power==nil)
      {
        //printf("Power is nil.  ");
        continue; 
      }
    float val2=[pEntityDetails2.m_Power floatValue];
    float maxVal2=MaximumYValue;
    float ratio2=val2/maxVal2;
    float height2=ratio2*MaximumHeight;
    
    float y2=(194-height2);
    float x2=(24+((i-47)*1.21));
    
    finalPoint=CGPointMake(x2, y2);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat red[4] = {0.0f, 1.0f, 0.0f, 1.0f};
    CGContextSetStrokeColor(c, red);
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, initialPoint.x,initialPoint.y);
    CGContextAddLineToPoint(c, finalPoint.x, finalPoint.y);
    CGContextStrokePath(c);
    }
  }  
  
  MaximumYValue=1200;
  MaximumHeight=184;            
  
  for(int i=48;i<247;i++)
  {
    if(i+1<[m_PowerArray count])
    {
      EntityDetails *pEntityDetails1=[m_PowerArray objectAtIndex:i];
      if(pEntityDetails1.m_DNI==nil)
      {
        //printf("DNI is nil.  ");
       continue; 
      }
      float val1=[pEntityDetails1.m_DNI floatValue];
      float maxVal1=MaximumYValue;
      float ratio1=val1/maxVal1;
      float height1=ratio1*MaximumHeight;
      
      float y1=((194-height1));
      float x1=(24+((i-48)*1.21));
      
      initialPoint=CGPointMake(x1, y1);
      
      EntityDetails *pEntityDetails2=[m_PowerArray objectAtIndex:i+1];
      if(pEntityDetails2.m_DNI==nil)
      {
        //printf("DNI is nil.  ");
        continue; 
      }
      float val2=[pEntityDetails2.m_DNI floatValue];
      float maxVal2=MaximumYValue;
      float ratio2=val2/maxVal2;
      float height2=ratio2*MaximumHeight;
      
      float y2=((194-height2));
      float x2=(24+((i-47)*1.21));
      
      finalPoint=CGPointMake(x2, y2);
      
      CGContextRef c = UIGraphicsGetCurrentContext();
      
      

      CGFloat red[4] = {0.871f, 0.89f, 0.0f, 1.0f};
      CGContextSetStrokeColor(c, red);
      CGContextBeginPath(c);
      CGContextMoveToPoint(c, initialPoint.x,initialPoint.y);
      CGContextAddLineToPoint(c, finalPoint.x, finalPoint.y);
      CGContextStrokePath(c);
    }
  }  
}
@end
