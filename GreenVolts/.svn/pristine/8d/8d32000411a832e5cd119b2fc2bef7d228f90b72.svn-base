//
//  TileDisplayTableViewCell.m
//  GreenVolts
//
//  Created by YML on 25/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "TileDisplayTableViewCell.h"
#import "Section.h"
#import "Array.h"
#import "String.h"
#import "EachTileView.h"
@interface TileDisplayTableViewCell()<EachTileViewDelegate>
-(void)displayDataForTileAtPosition:(int)position fromObject:(NSObject*)pObject;
@end
@implementation TileDisplayTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) 
  {
    [self drawObjects];
    delegate=nil;
    myRow=0;
  }
  return self;
}

-(void)drawObjects {
  firstTile=[[EachTileView alloc]initWithFrame:CGRectMake(12,0, 122, 110)];
  firstTile.m_delegate=self;
  [self addSubview:firstTile];

  secondTile=[[EachTileView alloc]initWithFrame:CGRectMake(146,0, 122, 110)];
  secondTile.m_delegate=self;
  [self addSubview:secondTile];
}

-(void)dealloc
{
  delegate=nil;
  firstTile=nil;
  secondTile=nil;
  thirdTile=nil;
}
#pragma mark -- Data Display Methods
-(void)displayDataFrom:(NSArray *)valueArray inRow:(int)row
{
  myRow=row;
  if([valueArray count]==2)
  {
    firstTile.m_Index=row*2;
    secondTile.m_Index=(row*2)+1;
    secondTile.hidden=NO;
    [self displayDataForTileAtPosition:1 fromObject:[valueArray objectAtIndex:0]];
    [self displayDataForTileAtPosition:2 fromObject:[valueArray objectAtIndex:1]];
  }
  else
  {
    firstTile.m_Index=row*2;
    secondTile.hidden=YES;
    [self displayDataForTileAtPosition:1 fromObject:[valueArray objectAtIndex:0]];
  }
}

#pragma mark -- Helper Methods
-(void)displayDataForTileAtPosition:(int)position fromObject:(NSObject*)pObject
{
  EachTileView *pEachTileView=nil;
  if(position==1)
    pEachTileView=firstTile;
  else if(position==2)
    pEachTileView=secondTile;
  else if(position==3)
    pEachTileView=thirdTile;
  NSNumberFormatter *frmtr = [[NSNumberFormatter alloc] init];
  [frmtr setGroupingSize:3];
  [frmtr setGroupingSeparator:@","];
  [frmtr setUsesGroupingSeparator:YES];
  if([pObject isKindOfClass:[Section class]])
  {
    Section *pSection=(Section*)pObject;
    if(pEachTileView)
    {
      [pEachTileView setEachTileTodayKWH:[frmtr stringFromNumber:pSection.m_TodayEnergy]];
      [pEachTileView setEachTileCurrentKW:pSection.m_CurrentPower];
      [pEachTileView setEachTileTitle:pSection.m_Name];
      
      if(pSection.AlarmCount==0)
        [pEachTileView setEachTileAlertImageName:@"Alert-Green.png"];
      else 
        [pEachTileView setEachTileAlertImageName:@"Alert-red.png"];
      
      float scale=pSection.ArrayCount*16;
      int range=ceil(scale/4.0);
      
      [pEachTileView setEachTileValue1:[NSString stringWithFormat:@"%d",range*0]];
      [pEachTileView setEachTileValue2:[NSString stringWithFormat:@"%d",range*1]];
      [pEachTileView setEachTileValue3:[NSString stringWithFormat:@"%d",range*2]];
      [pEachTileView setEachTileValue4:[NSString stringWithFormat:@"%d",range*3]];
      [pEachTileView setEachTileValue5:[NSString stringWithFormat:@"%d",range*4]];
      
      if([pSection.m_CurrentPower floatValue]<=scale/2)
      {
        float angle=((108.0)*([pSection.m_CurrentPower floatValue]))/(scale/2);
        float rotationAngle=252.0+angle;
        [pEachTileView setEachTileNeedleRotationAngle:(rotationAngle*0.0174532925)];
      }
      else 
      {
        float angle=((108.0)*([pSection.m_CurrentPower floatValue]-(scale/2)))/(scale/2);
        [pEachTileView setEachTileNeedleRotationAngle:(angle*0.0174532925)];            
      }
    }
  }
  else if([pObject isKindOfClass:[Array class]])
  {
    Array *pArray=(Array*)pObject;
    if(pEachTileView)
    {
      [pEachTileView setEachTileTodayKWH:[frmtr stringFromNumber:pArray.m_TodayEnergy]];
      [pEachTileView setEachTileCurrentKW:pArray.m_CurrentPower];
      [pEachTileView setEachTileTitle:pArray.m_Name];
      
      if(pArray.AlarmCount==0)
        [pEachTileView setEachTileAlertImageName:@"Alert-Green.png"];
      else 
        [pEachTileView setEachTileAlertImageName:@"Alert-red.png"];
      
      float scale=1*16;
      int range=ceil(scale/4.0);
      
      [pEachTileView setEachTileValue1:[NSString stringWithFormat:@"%d",range*0]];
      [pEachTileView setEachTileValue2:[NSString stringWithFormat:@"%d",range*1]];
      [pEachTileView setEachTileValue3:[NSString stringWithFormat:@"%d",range*2]];
      [pEachTileView setEachTileValue4:[NSString stringWithFormat:@"%d",range*3]];
      [pEachTileView setEachTileValue5:[NSString stringWithFormat:@"%d",range*4]];
      
      if([pArray.m_CurrentPower floatValue]<=scale/2)
      {
        float angle=((108.0)*([pArray.m_CurrentPower floatValue]))/(scale/2);
        float rotationAngle=252.0+angle;
        [pEachTileView setEachTileNeedleRotationAngle:(rotationAngle*0.0174532925)];      
      }
      else 
      {
        float angle=((108.0)*([pArray.m_CurrentPower floatValue]-(scale/2)))/(scale/2);
        [pEachTileView setEachTileNeedleRotationAngle:(angle*0.0174532925)];            
      }
    }
  }
  else if([pObject isKindOfClass:[String class]])
  {
    String *pString=(String*)pObject;
    if(pEachTileView)
    {
      [pEachTileView setEachTileTodayKWH:[frmtr stringFromNumber:pString.m_TodayEnergy]];
      [pEachTileView setEachTileCurrentKW:pString.m_CurrentPower];
      [pEachTileView setEachTileTitle:pString.m_Name];
      
      if(pString.AlarmCount==0)
        [pEachTileView setEachTileAlertImageName:@"Alert-Green.png"];
      else 
        [pEachTileView setEachTileAlertImageName:@"Alert-red.png"];
      
      float scale=(16/pString.StringCount);
      int range=ceil(scale/4.0);
      
      [pEachTileView setEachTileValue1:[NSString stringWithFormat:@"%d",range*0]];
      [pEachTileView setEachTileValue2:[NSString stringWithFormat:@"%d",range*1]];
      [pEachTileView setEachTileValue3:[NSString stringWithFormat:@"%d",range*2]];
      [pEachTileView setEachTileValue4:[NSString stringWithFormat:@"%d",range*3]];
      [pEachTileView setEachTileValue5:[NSString stringWithFormat:@"%d",range*4]];
      
      if([pString.m_CurrentPower floatValue]<=scale/2)
      {
        float angle=((108.0)*([pString.m_CurrentPower floatValue]))/(scale/2);
        float rotationAngle=252.0+angle;
        [pEachTileView setEachTileNeedleRotationAngle:(rotationAngle*0.0174532925)];      
      }
      else 
      {
        float angle=((108.0)*([pString.m_CurrentPower floatValue]-(scale/2)))/(scale/2);
        [pEachTileView setEachTileNeedleRotationAngle:(angle*0.0174532925)];            
      }
    }
  }
}
#pragma mark -- EachTileViewDelegate Methdods
-(void)TileClicked:(EachTileView *)pEachTileView
{
  if(delegate)
  {
    if ([delegate respondsToSelector:@selector(selectedTileAtIndex:)]) 
    {
      [delegate selectedTileAtIndex:pEachTileView.m_Index];
    }
  }
}
@end
