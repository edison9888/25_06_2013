//
//  PowerVsDNIScrollView.h
//  GreenVolts
//
//  Created by YML on 9/13/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PowerVsDNIView.h"

@interface PowerVsDNIScrollView : UIView<UIScrollViewDelegate> 
{
  UILabel *m_DayLabel;
  UIScrollView *m_ScrollView;
  PowerVsDNIView *m_PowerVsDNIView;
}
-(void)fillValuesFrom:(NSArray*)pArray andArrayCount:(int)count;

@end
