//
//  
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InverterViewDelegate<NSObject>

-(void)finishedDownloading:(NSArray *)pArray;
-(void)fetchSessionTokenforInverter;
@end


@interface InverterView : UIView 
{
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  UIActivityIndicatorView *m_ActivityIndicatorView;        
  
  NSArray *m_InverterArray;
  UILabel *m_LabelW1;
  UILabel *m_LabelW2;
  UILabel *m_LabelW3;
  UILabel *m_LabelW4;
  
  UILabel *m_LabelE1;
  UILabel *m_LabelE2;
  UILabel *m_LabelE3;
  UILabel *m_LabelE4;
} 
@property(nonatomic,assign) id<InverterViewDelegate> m_delegate;
-(void)reloadInverter;
-(void)cleanUp;
@end
