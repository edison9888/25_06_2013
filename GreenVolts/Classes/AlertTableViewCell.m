//
//  AlertTableViewCell.m
//  GreenVolts
//
//  Created by YML on 9/21/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "AlertTableViewCell.h"


@implementation AlertTableViewCell
@synthesize m_TilteLabel,m_AlarmLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{    
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) 
  {
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgImgView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CellBG" ofType:@"png"]];
    self.backgroundView=bgImgView;
    
    m_TilteLabel=[[UILabel alloc]initWithFrame:CGRectMake(2, 6, 250, 12)];
    [m_TilteLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
    m_TilteLabel.textColor=[UIColor colorWithRed:(70.2/100.0) green:(71.4/100.0) blue:(71.8/100.0) alpha:1.0];
    m_TilteLabel.backgroundColor=[UIColor clearColor];
    [self addSubview:m_TilteLabel];
    
    m_AlarmLabel=[[UILabel alloc]initWithFrame:CGRectMake(281, 6, 50, 12)];
    [m_AlarmLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12]];
    m_AlarmLabel.textColor=[UIColor colorWithRed:(70.2/100.0) green:(71.4/100.0) blue:(71.8/100.0) alpha:1.0];
    m_AlarmLabel.backgroundColor=[UIColor clearColor];
    m_AlarmLabel.textAlignment=UITextAlignmentLeft;
    [self addSubview:m_AlarmLabel];
  }
  return self;
}
@end
