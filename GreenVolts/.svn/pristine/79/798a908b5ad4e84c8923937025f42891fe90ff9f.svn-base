//
//  StringViewController.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTileView.h"
#import "PowerVsDNIScrollView.h"
#import "TotalEnergyView.h"
#import "String.h"
#import "Connection.h"
#import "WebserviceProcessor.h"
#import "PagingView.h"
@interface StringViewController : UIViewController <WebserviceProcessorDelegate,PagingViewDelegate,PagingViewDataSource>
{
  String *m_String;
  
  UIButton *m_Backbutton;
  
  TopTileView *m_TopTileView;
  PowerVsDNIScrollView *m_PowerVsDNIView;
  TotalEnergyView *m_TotalEnergyView;
  
  UISlider *m_Slider;
  BOOL m_bTapped;

  UILabel *m_TitleLabel;

  WebserviceProcessor* m_webserviceProcessor;
  NSString* m_parseStringListURL;  
  NSString* m_parseArrayDetailsURL;
  NSString* m_parseTotalEnergyURL;
  NSString* m_parseTopViewDataURL;

  Connection *mConnection;
  UIActivityIndicatorView *m_ActivityIndicatorView;
  
  int mPreviousValue,mCurrentValue;
  BOOL isEnergyView,isPowerView;

  BOOL isDateChanged;
  
  int lastSelectedDay;
  BOOL isReloading;
  PagingView *mPagingView;
}
-(id)initWithString:(String *)pString;
@end
