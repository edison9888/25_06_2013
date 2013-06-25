//
//  AlertTableViewCell.h
//  GreenVolts
//
//  Created by YML on 9/21/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlertTableViewCell : UITableViewCell 
{
  UILabel *m_TilteLabel;
  UILabel *m_AlarmLabel;
}
@property(strong,nonatomic,readonly) UILabel *m_TilteLabel;
@property(strong,nonatomic,readonly) UILabel *m_AlarmLabel;
@end
