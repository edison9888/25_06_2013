//
//  DrawWindGraphView.m
//  GreenVolts
//
//  Created by YML on 9/15/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "DrawWindGraphView.h"
@interface DrawWindGraphView()
-(CGFloat)yOffsetForValue:(float)value;
@end
@implementation DrawWindGraphView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)pArray maximumValue:(float)maxVal
{    
    self = [super initWithFrame:frame];
    if (self) 
    {
      m_YValueArray=[NSArray arrayWithArray:pArray];
      
      MaximumYValue=maxVal;

      [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
  CGPoint initialPoint,finalPoint;
  if([m_YValueArray count]>1)
  {
    for(int i=0;i<[m_YValueArray count]-1;i++)
    {
      NSString *pVal1=[m_YValueArray objectAtIndex:i];
      float val1=[pVal1 floatValue];
      float y1=[self yOffsetForValue:val1];
      float x1=(i*(0.958));
      
      initialPoint=CGPointMake(x1, y1);
      
      NSString *pVal2=[m_YValueArray objectAtIndex:i+1];
      float val2=[pVal2 floatValue];
      float y2=[self yOffsetForValue:val2];
      float x2=((i+1)*(0.958));
      
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
}

-(CGFloat)yOffsetForValue:(float)value
{
  int MaximumHeight=self.bounds.size.height;
  CGFloat yOffset=0;
  float yOffsetForSingleValue=MaximumHeight/MaximumYValue;
  yOffset=yOffsetForSingleValue*value;
  yOffset=MaximumHeight-yOffset;
  return yOffset;
}
-(void)dealloc
{
  //printf("Dealloc in DrawWindGraphView\n");
  m_YValueArray=nil;
}
@end
