//
//  TileDisplayTableViewCell.h
//  GreenVolts
//
//  Created by YML on 25/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <UIKit/UIKit.h>
@class EachTileView;
@protocol TileDisplayTableViewCellDelegate<NSObject>
-(void)selectedTileAtIndex:(int)index;
@end
@interface TileDisplayTableViewCell : UITableViewCell
{
  int myRow;
  EachTileView *firstTile;
  EachTileView *secondTile;
  EachTileView *thirdTile;
}
@property(nonatomic,assign)id<TileDisplayTableViewCellDelegate> delegate;
-(void)displayDataFrom:(NSArray*)valueArray inRow:(int)row;
-(void)displayDataForTileAtPosition:(int)position fromObject:(NSObject*)pObjec;
-(void)drawObjects;
@end
