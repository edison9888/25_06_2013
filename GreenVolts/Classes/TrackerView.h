//
//  TrackerView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrackerViewDelegate<NSObject>

-(void)fetchSessionTokenforTracker;

@end


@interface TrackerView : UIView
{
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  UIActivityIndicatorView *m_ActivityIndicatorView;
  UIImageView *m_Tilt1Tracker;
  UIImageView *m_Tilt2Tracker;
  UIImageView *m_Tilt3Tracker;
  UIImageView *m_Tilt4Tracker;
  UIImageView *m_RollTracker;
}
@property(nonatomic,assign) id<TrackerViewDelegate> m_delegate;
-(void)reloadTracker;
@end
