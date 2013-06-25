//
//  AllTilesListView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "AllTilesListView.h"
#import "Section.h"
#import "Array.h"
#import "String.h"
#import "TileDisplayTableViewCell.h"
@interface AllTilesListView()<TileDisplayTableViewCellDelegate>
-(NSArray*)getObjectesToBeDisplayedForRow:(int)row;
@end
@implementation AllTilesListView
@synthesize m_deleagte;

- (id)initWithFrame:(CGRect)frame 
{    
  CGSize size=frame.size;
  size.height-=25;
  size.width-=20;
  frame.size=size;
  
  CGPoint origin=frame.origin;
  origin.y+=15;
  origin.x+=10;
  frame.origin=origin;
  
  self = [super initWithFrame:frame];
  if (self) 
  {
    frame.origin.x=0.0;
    frame.origin.y=0.0;
    m_TilesValueArray=nil;
    m_TableView=[[UITableView alloc]initWithFrame:self.bounds];
    m_TableView.dataSource=self;
    m_TableView.delegate=self;
    m_TableView.backgroundColor=[UIColor clearColor];
    m_TableView.separatorColor=[UIColor clearColor];
    [self addSubview:m_TableView];
  }
  return self;
}

- (void)dealloc 
{
  m_deleagte=nil;
  m_TilesValueArray=nil;
  //printf("Dealloc in AllTilesListView\n");
}


-(void)fillScrollViewWithArray:(NSArray *)valueArray
{  
  m_TilesValueArray=nil;
  m_TilesValueArray=[NSArray arrayWithArray:valueArray];
  [m_TableView reloadData];
}

#pragma mark -- Helper Methods
-(NSArray*)getObjectesToBeDisplayedForRow:(int)row
{
  NSMutableArray *array=[NSMutableArray array];
  int firstIndex=row*2;
  int secondIndex=(row*2)+1;
  if(firstIndex<[m_TilesValueArray count])
    [array addObject:[m_TilesValueArray objectAtIndex:firstIndex]];
  if(secondIndex<[m_TilesValueArray count])
    [array addObject:[m_TilesValueArray objectAtIndex:secondIndex]];
  return array;
}
#pragma mark -- UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  int noOfRows=0;
  if(!m_TilesValueArray)
    noOfRows=0;
  else if([m_TilesValueArray count]%2==0)
    noOfRows=[m_TilesValueArray count]/2;
  else
    noOfRows=[m_TilesValueArray count]/2+1;
  return noOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  TileDisplayTableViewCell *cell=nil;
  static NSString *cellIdentfier=@"CellIdentifier";
  cell=[tableView dequeueReusableCellWithIdentifier:cellIdentfier];
  if(cell==nil)
  {
    cell=[[TileDisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
  }
  [cell displayDataFrom:[self getObjectesToBeDisplayedForRow:indexPath.row] inRow:indexPath.row];
  return cell;
}

#pragma mark -- UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 120;
}

#pragma mark -- TileDisplayTableViewCellDelegate
-(void)selectedTileAtIndex:(int)index
{
  if(m_deleagte && [m_deleagte respondsToSelector:@selector(ClickedTileWithIndex:)])
    [m_deleagte ClickedTileWithIndex:index];  
}
@end
