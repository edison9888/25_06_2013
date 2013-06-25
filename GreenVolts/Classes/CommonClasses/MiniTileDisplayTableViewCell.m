//
//  MiniTileDisplayTableViewCell.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MiniTileDisplayTableViewCell.h"

@interface MiniTileDisplayTableViewCell(PVT)<EachTileViewDelegate>

@end

@implementation MiniTileDisplayTableViewCell
-(void)drawObjects {
    firstTile=[[MiniEachTileView alloc]initWithFrame:CGRectMake(4,0, 90, 84)];
    firstTile.m_delegate=self;
    [self addSubview:firstTile];
    
    secondTile=[[MiniEachTileView alloc]initWithFrame:CGRectMake(98,0, 90, 84)];
    secondTile.m_delegate=self;
    [self addSubview:secondTile];
    
    thirdTile=[[MiniEachTileView alloc]initWithFrame:CGRectMake(192, 0, 90, 84)];
    thirdTile.m_delegate=self;
    [self addSubview:thirdTile];    
}

#pragma mark -- Data Display Methods
-(void)displayDataFrom:(NSArray *)valueArray inRow:(int)row
{
    myRow=row;
    firstTile.m_Index=row*3;
    secondTile.m_Index=(row*3)+1;
    thirdTile.m_Index=(row*3)+2;

    if([valueArray count]==3) {
        secondTile.hidden=NO;
        thirdTile.hidden=NO;
        [self displayDataForTileAtPosition:1 fromObject:[valueArray objectAtIndex:0]];
        [self displayDataForTileAtPosition:2 fromObject:[valueArray objectAtIndex:1]];    
        [self displayDataForTileAtPosition:3 fromObject:[valueArray objectAtIndex:2]];
    }
    else if([valueArray count]==2) {
        secondTile.hidden=NO;
        thirdTile.hidden=YES;
        [self displayDataForTileAtPosition:1 fromObject:[valueArray objectAtIndex:0]];
        [self displayDataForTileAtPosition:2 fromObject:[valueArray objectAtIndex:1]];
    }
    else {
        secondTile.hidden=YES;
        thirdTile.hidden=YES;
        [self displayDataForTileAtPosition:1 fromObject:[valueArray objectAtIndex:0]];
    }
}

@end
