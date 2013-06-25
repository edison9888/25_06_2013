//
//  ArrayViewController.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTileView.h"
#import "AllTilesListView.h"
#import "PowerVsDNIScrollView.h"
#import "TotalEnergyView.h"
#import "WindScrollView.h"
#import "CameraScrollView.h"
#import "TrackerView.h"
#import "InverterView.h"
#import "InverterListView.h"
#import "Array.h"
#import "Connection.h"
#import "WebserviceProcessor.h"
#import "PagingView.h"
@interface ArrayViewController : UIViewController <WebserviceProcessorDelegate,PagingViewDelegate,PagingViewDataSource>
{
  Array *m_Array;
  UIButton *m_Backbutton;

  TopTileView *m_TopTileView;
  AllTilesListView *m_AllTilesListView;
  PowerVsDNIScrollView *m_PowerVsDNIView;
  TotalEnergyView *m_TotalEnergyView;
  WindScrollView *m_WindView;
  CameraScrollView *m_CameraScrollView;
  TrackerView *m_TrackerView;
  InverterView *m_InverterView;
  InverterListView *m_InverterListViewDCWest;
  InverterListView *m_InverterListViewDCEast;
  InverterListView *m_InverterListViewAC;

  UISlider *m_Slider;
  BOOL m_bTapped;
  UILabel *m_TitleLabel;
  UIImageView *m_BackgroundImageView;
  UIImageView *m_InverterImageView;
  
  int mPreviousValue,mCurrentValue,level;
  BOOL isDateChanged;

  WebserviceProcessor* m_webserviceProcessor;
  NSString* m_parseStringListURL;  
  NSString* m_parseArrayDetailsURL;
  NSString* m_parseTotalEnergyURL;
  NSString* m_parseTopViewDataURL;
  
  Connection *mConnection;
  UIActivityIndicatorView *m_ActivityIndicatorView;    
  
  BOOL isGoingToNextLevel;
  
  int lastSelectedDay;
  BOOL isReloading;
  PagingView *mPagingView;
  
  BOOL isServerConnectionActive;
}
-(id)initWithArray:(Array *)pArray;
@end
