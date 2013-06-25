//
//  CameraScrollView.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraScrollView.h"

@implementation CameraScrollView
@synthesize m_CameraView, m_PagingView, canScrollRight;

- (id)initWithFrame:(CGRect)frame CameraID:(int)pCameraId PagingView:(PagingView *)pPaging canScrollRight:(bool)pCanScrollRight; 
{
    self=[super initWithFrame:frame];
    if(self)
    {       
        m_ScrollView=[[UIScrollView alloc]initWithFrame:frame];
        [m_ScrollView delaysContentTouches];
        m_ScrollView.clipsToBounds=YES;
        m_ScrollView.delegate=self;
        m_ScrollView.showsHorizontalScrollIndicator=NO;
        m_ScrollView.showsVerticalScrollIndicator=NO;
        m_ScrollView.contentMode = (UIViewContentModeScaleAspectFit);
        m_ScrollView.contentSize=CGSizeMake(303, 245);
        m_ScrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        m_ScrollView.maximumZoomScale=4.0;
        m_ScrollView.minimumZoomScale=1.0;
        m_ScrollView.alwaysBounceVertical=NO;
        [self addSubview:m_ScrollView];      
        
        m_CameraView=[[CameraView alloc]initWithFrame:CGRectMake(3, 15, 298, 225) CameraID:pCameraId];
        [m_ScrollView addSubview:m_CameraView]; 
        
        m_PagingView = pPaging;
        canScrollRight = pCanScrollRight;
    }
    return self;
}

-(void)dealloc
{
    [m_CameraView removeFromSuperview];
    m_CameraView=nil;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
    return [scrollView.subviews objectAtIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.zoomScale > 1.0 && scrollView.contentOffset.x < -60) {
        m_ScrollView.zoomScale = 1.0;        
        [m_PagingView loadPreviousView];
    }
    if (scrollView.zoomScale > 1.0 && scrollView.contentOffset.x - 60 > (scrollView.contentSize.width - scrollView.frame.size.width) && canScrollRight) {
        m_ScrollView.zoomScale = 1.0;
        [m_PagingView loadNextView];
    }
}
@end

