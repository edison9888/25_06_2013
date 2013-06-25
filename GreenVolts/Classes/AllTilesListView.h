//
//  AllTilesListView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EachTileView.h"

@protocol AllTilesListViewDelegate<NSObject>

-(void)ClickedTileWithIndex:(int)index;

@end


@interface AllTilesListView : UIScrollView <UITableViewDataSource,UITableViewDelegate>
{
  NSArray *m_TilesValueArray;
  UITableView *m_TableView;
}
-(void)fillScrollViewWithArray:(NSArray *)valueArray;
@property(nonatomic,assign) id<AllTilesListViewDelegate> m_deleagte;
@end
