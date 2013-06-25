//
//  WindScrollView.h
//  GreenVolts
//
//  Created by YML on 9/14/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WindView.h"

@protocol WindScrollViewDelegate<NSObject>

-(void)fetchSessionTokenforWindScrollView;

@end

@interface WindScrollView : UIView <UIScrollViewDelegate,WindViewDelegate>
{
  UILabel *m_DayLabel;
  WindView *m_WindView;
}
-(void)fillValuesFrom:(NSArray*)values;
@property(nonatomic,assign) id<WindScrollViewDelegate> m_delegate;
@end
