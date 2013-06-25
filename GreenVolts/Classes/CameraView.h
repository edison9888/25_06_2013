//
//  CameraView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"

@protocol CameraViewDelegate<NSObject>

-(void)fetchSessionTokenforCamera;

@end


@interface CameraView : UIView 
{
  int mCameraId;
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  NSTimer *m_Timer;
  BOOL isConnection;
  UIImageView *m_ImageView;
}
- (id)initWithFrame:(CGRect)frame CameraID:(int)pCameraId;
-(void)cleanUp;
@property(nonatomic,assign) id<CameraViewDelegate> m_deleagte;
@property(nonatomic,assign) BOOL isVisible;
@end
