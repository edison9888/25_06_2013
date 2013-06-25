//
//  TileViewController.h
//  GreenVolts
//
//  Created by YML on 8/26/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTileView.h"
#import "AllTilesListView.h"
#import "TotalEnergyView.h"
#import "WindScrollView.h"
#import "CameraScrollView.h"
#import "PowerVsDNIScrollView.h"
#import "Site.h"
#import "Connection.h"
#import "DataPrefetcher.h"
#import "WebserviceProcessor.h"
#import "PagingView.h"

@interface SiteViewController : UIViewController <WebserviceProcessorDelegate,PagingViewDelegate,PagingViewDataSource>
{
  Site *m_Site;  
  
  UIButton *m_Backbutton;
  
  TopTileView *m_TopTileView;
  AllTilesListView *m_AllTilesListView;
  PowerVsDNIScrollView *m_PowerVsDNIView;
  TotalEnergyView *m_TotalEnergyView;
  WindScrollView *m_WindView;
  CameraScrollView *m_CameraScrollView;
  
  UILabel *m_TitleLabel;
  UISlider *m_Slider;
  BOOL m_bTapped;
  UIImageView *m_BackgroundImageView;
  int mPreviousValue;
  BOOL isDateChanged;
  
  WebserviceProcessor* m_webserviceProcessor;
  NSString* m_parseStringListURL;  
  NSString* m_parseArrayDetailsURL;
  NSString* m_parseTotalEnergyURL;
  NSString* m_parseTopViewDataURL;

  Connection *mConnection;
  UIActivityIndicatorView *m_ActivityIndicatorView;
  
  DataPrefetcher *mDataPrefetcher;
  int lastSelectedDay;
  BOOL isGoingToNextLevel;
  BOOL isReloading;
  
  PagingView *mPagingView;
}
-(id)initWithSite:(Site *)pSite;
@end
