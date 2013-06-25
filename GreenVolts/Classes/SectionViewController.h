//
//  SectionViewController.h
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
#import "Section.h"
#import "Connection.h"
#import "DataPrefetcher.h"
#import "WebserviceProcessor.h"
#import "PagingView.h"

@interface SectionViewController : UIViewController <WebserviceProcessorDelegate,PagingViewDataSource,PagingViewDelegate>
{
  Section *m_Section;
  
  UIButton *m_Backbutton;
  
  TopTileView *m_TopTileView;
  AllTilesListView *m_AllTilesListView;
  PowerVsDNIScrollView *m_PowerVsDNIView;
  TotalEnergyView *m_TotalEnergyView;
  WindScrollView *m_WindView;
  CameraScrollView *m_CameraScrollView;

  UISlider *m_Slider;
  BOOL m_bTapped;
  UILabel *m_TitleLabel;
  UIImageView *m_BackgroundImageView;

  int mPreviousValue,mCurrentValue,level;
  BOOL isGoBack;
  BOOL isDateChanged;

  WebserviceProcessor* m_webserviceProcessor;
  NSString* m_parseStringListURL;  
  NSString* m_parseArrayDetailsURL;
  NSString* m_parseTotalEnergyURL;
  NSString* m_parseTopViewDataURL;

  Connection *mConnection;
  UIActivityIndicatorView *m_ActivityIndicatorView;  
  
  DataPrefetcher *mDataPrefetcher;
  BOOL isGoingToNextLevel;
  int lastSelectedDay;
  BOOL isReloading;
  
  PagingView *mPagingView;
}
-(id)initWithSection:(Section *)pSection;
@end
