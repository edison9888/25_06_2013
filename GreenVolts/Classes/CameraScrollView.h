//
//  CameraScrollView.h
//  GreenVolts
//
//  Created by Jos Vandevelde on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"
#import "PagingView.h"

@interface CameraScrollView : UIView<UIScrollViewDelegate> 
{
    UIScrollView *m_ScrollView;
}
- (id)initWithFrame:(CGRect)frame CameraID:(int)pCameraId PagingView:(PagingView*)pPaging canScrollRight:(bool)pCanScrollRight;

@property(nonatomic,retain,readonly) CameraView *m_CameraView;
@property(nonatomic,retain,readonly) PagingView *m_PagingView;
@property(nonatomic,assign,readonly) bool canScrollRight;
@end