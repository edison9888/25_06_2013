//
//  PagingView.m
//  ScrollViewSlideSample
//
//  Created by YML on 24/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "PagingView.h"
@interface PagingView()<UIScrollViewDelegate>

-(void)callDelegateMethods;
@end
@implementation PagingView
@synthesize delegate,dataSource;
@synthesize isEnabled;
@dynamic currentPage;
-(id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if(self)
  {
    isEnabled=YES;
    delegate=nil;
    CGRect bounds=self.bounds;
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    [self addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    
    CGRect pageControlFrame=CGRectMake(0,bounds.size.height-7,bounds.size.width,10);
    _pageControl=[[UIPageControl alloc]initWithFrame:pageControlFrame];
    _pageControl.currentPage=0;
    _pageControl.userInteractionEnabled=NO;
    [self addSubview:_pageControl];
    
    currentView=nil;
    nextView=nil;
    [self performSelector:@selector(callDelegateMethods) withObject:self afterDelay:0.3];
  }
  return self;
}
-(void)dealloc
{
  delegate=nil;
  //printf("Dealloc Called in PagingView\n");
  currentView=nil;
  nextView=nil;
}
#pragma mark -- SwipeGestureHandlerƒ
-(void)handleSwipe:(UISwipeGestureRecognizer*)swipeGesture
{
  if(!isEnabled)
    return;
  if(swipeGesture.direction==UISwipeGestureRecognizerDirectionLeft) //Left Swipe
  {
    //Notify the delegate
    if((_pageControl.currentPage+1)<_pageControl.numberOfPages)
    {
      if(delegate)
      {
        if([delegate respondsToSelector:@selector(pagingView:willDisplayPage:)])
        {
          [delegate pagingView:self willDisplayPage:_pageControl.currentPage+1];
        }
      }
    }
    [self loadNextView];
  }
  else if(swipeGesture.direction==UISwipeGestureRecognizerDirectionRight) //Right Swipe
  {
    if((_pageControl.currentPage-1)>=0)
    {
      if(delegate)
      {
        if([delegate respondsToSelector:@selector(pagingView:willDisplayPage:)])
        {
          [delegate pagingView:self willDisplayPage:_pageControl.currentPage-1];
        }
      }
    }
    [self loadPreviousView];
  }
}
-(void)loadNextView
{
  if((_pageControl.currentPage+1)<_pageControl.numberOfPages)
  {
    isEnabled=NO;
    currentViewFrame=currentView.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    currentView.frame=CGRectMake(currentView.frame.origin.x-(self.bounds.size.width+100),currentView.frame.origin.y,currentView.frame.size.width,currentView.frame.size.height);
    [UIView commitAnimations];
    _pageControl.currentPage++;
  }
}
-(void)loadPreviousView
{
  if((_pageControl.currentPage-1)>=0)
  {
    isEnabled=NO;
    currentViewFrame=currentView.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    currentView.frame=CGRectMake(currentView.frame.origin.x+(self.bounds.size.width+100),currentView.frame.origin.y,currentView.frame.size.width,currentView.frame.size.height);
    [UIView commitAnimations];
    _pageControl.currentPage--;
  }
}
-(void)animationFinished
{
  if(dataSource)
  {
    currentView.frame=currentViewFrame;
    nextView=[dataSource pagingView:self viewForPage:_pageControl.currentPage];
    if(nextView)
    {
      [currentView removeFromSuperview];
      currentView=nil;
      currentView=nextView;
      nextView=nil;
      [self addSubview:currentView];
    }
    if(delegate)
    {
      if([delegate respondsToSelector:@selector(pagingView:didDisplayPage:)])
      {
        [delegate pagingView:self didDisplayPage:_pageControl.currentPage];
      }
    }
  }
  isEnabled=YES;
}
-(void)callDelegateMethods
{
  if(dataSource)
  {
    _noOfPages=[dataSource pagingViewNoOfPages:self];
  }
  if(_noOfPages>0)
  {
    _pageControl.numberOfPages=_noOfPages;
    _pageControl.currentPage=0;
    if(dataSource)
    {
      currentView=[dataSource pagingView:self viewForPage:_pageControl.currentPage];
      [self addSubview:currentView];
    }
  }
}
-(NSInteger)getCurrentPage
{
  return _pageControl.currentPage;
}
@end
