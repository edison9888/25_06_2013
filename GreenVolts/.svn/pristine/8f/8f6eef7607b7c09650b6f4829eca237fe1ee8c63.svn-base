//
//  AllMiniTilesListView.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllMiniTilesListView.h"

@interface AllMiniTilesListView(PVT)<TileDisplayTableViewCellDelegate>

@end

@implementation AllMiniTilesListView
#pragma mark -- Helper Methods
-(NSArray*)getObjectsToBeDisplayedForRow:(int)row {
    NSMutableArray *array=[NSMutableArray array];
    int firstIndex=row*3;
    int secondIndex=(row*3)+1;
    int thirdIndex=(row*3)+2;
    
    if(firstIndex<[m_TilesValueArray count])
        [array addObject:[m_TilesValueArray objectAtIndex:firstIndex]];
    if(secondIndex<[m_TilesValueArray count])
        [array addObject:[m_TilesValueArray objectAtIndex:secondIndex]];
    if(thirdIndex<[m_TilesValueArray count])
        [array addObject:[m_TilesValueArray objectAtIndex:thirdIndex]];
    return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TileDisplayTableViewCell *cell=nil;
    static NSString *cellIdentfier=@"CellIdentifier";
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    if(cell==nil)
    {
        cell=[[MiniTileDisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    }
    [cell displayDataFrom:[self getObjectsToBeDisplayedForRow:indexPath.row] inRow:indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int noOfRows=0;
    if(!m_TilesValueArray)
        noOfRows=0;
    else if([m_TilesValueArray count]%3==0)
        noOfRows=[m_TilesValueArray count]/3;
    else
        noOfRows=[m_TilesValueArray count]/3+1;
    return noOfRows;
}

#pragma mark -- UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}
@end
