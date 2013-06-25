//
//  DrawGraphView.h
//  GreenVolts
//
//  Created by YML on 9/14/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrawGraphView : UIView
{
  int MaximumYValue;
  NSArray *m_PowerArray;  
}
-(void)drawGraphWithArray:(NSArray*)pArray andArrayCount:(int)count;
@end
