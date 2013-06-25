//
//  PagingView.h
//  ScrollViewSlideSample
//
//  Created by YML on 24/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PagingViewDelegate;
@protocol PagingViewDataSource;
@interface PagingView : UIView
{
  UIPageControl *_pageControl;
  int _noOfPages;
  UIView *currentView;
  UIView *nextView;
  CGRect currentViewFrame;
}
-(void)loadNextView;
-(void)loadPreviousView;
@property(nonatomic,assign)id <PagingViewDelegate> delegate;
@property(nonatomic,assign)id <PagingViewDataSource> dataSource;
@property(nonatomic)BOOL isEnabled; //By default YES
@property(nonatomic,readonly,getter = getCurrentPage)NSInteger currentPage;
@end

@protocol PagingViewDelegate <NSObject>
@optional
-(void)pagingView:(PagingView*)pagingView didDisplayPage:(NSInteger)page;
-(void)pagingView:(PagingView*)pagingView willDisplayPage:(NSInteger)page;
@end

@protocol PagingViewDataSource <NSObject>
-(NSInteger)pagingViewNoOfPages:(PagingView*)pagingView;
-(UIView*)pagingView:(PagingView*)pagingView viewForPage:(NSInteger)page;
@end