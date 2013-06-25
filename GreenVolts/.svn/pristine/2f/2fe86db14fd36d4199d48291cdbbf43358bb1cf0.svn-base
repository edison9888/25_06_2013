//
//  WindView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WindViewDelegate<NSObject>

-(void)fetchSessionTokenforWind;
@end


@interface WindView : UIView
{
  NSArray *m_YValueArray;
  NSArray *m_LevelArray;
  NSArray *m_WindDirectionArray;

  float MaximumHeight;
  float MaximumYValue;
  
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  UIActivityIndicatorView *m_ActivityIndicatorView;    
}
-(void)drawGraphFromValues:(NSArray*)values;
@property(nonatomic,assign) id<WindViewDelegate> m_deleagte;
@end
