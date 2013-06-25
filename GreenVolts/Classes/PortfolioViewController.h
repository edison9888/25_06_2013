//
//  DashBoardsViewController.h
//  GreenVolts
//
//  Created by YML on 8/26/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "DataPrefetcher.h"

@interface PortfolioViewController : UIViewController <DataPrefetcherDelegate,UITableViewDataSource,UITableViewDelegate>
{
  UILabel *pTitleLabel;
  
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  UIActivityIndicatorView *m_ActivityIndicatorView;
  
  Connection *mConnection;
  
  BOOL isReloading;
  DataPrefetcher *mDataPrefetcher;
  BOOL isServerConnectionActive;
  NSArray *availableSites;
  int noOfSiteTilesPresent;
  UITableView *mTableView;
}
@end
