//
//  TotalEnergyView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TotalEnergyViewDelegate<NSObject>

-(void)leftSwipe;
-(void)rightSwipe;

@end

@interface TotalEnergyView : UIView 
{
  float MaximumYValue;
  int range;
  UIScrollView *m_ScrollView;
  NSArray *m_ResultArray;
}
@property(nonatomic,assign) id<TotalEnergyViewDelegate> m_delegate;
-(void)drawGraphFromValues:(NSArray*)values;
@end
