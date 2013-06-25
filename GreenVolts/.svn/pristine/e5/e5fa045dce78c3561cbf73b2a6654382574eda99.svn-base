//
//  EachTileView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EachTileView;

@protocol EachTileViewDelegate<NSObject>

-(void)TileClicked:(EachTileView *)pEachTileView;

@end

@interface EachTileView : UIView 
{
  UILabel *m_TitleLabel; //String
  UILabel *m_TodayKWHValueLabel; //String
  UILabel *m_CurrentKWValueLabel; //String
  
  UILabel *m_ValueLabel1; //String
  UILabel *m_ValueLabel2; //String
  UILabel *m_ValueLabel3; //String
  UILabel *m_ValueLabel4; //String
  UILabel *m_ValueLabel5; //String
  
  UIImageView *m_NeedleImageView; //RotationAngle
  UIImageView *m_AlertImageView; //ImageName
}
@property(nonatomic,assign) int m_Index;
@property(nonatomic,assign) id<EachTileViewDelegate> m_delegate;

-(void)setEachTileTitle:(NSString*)value;
-(void)setEachTileTodayKWH:(NSString*)value;
-(void)setEachTileCurrentKW:(NSString*)value;
-(void)setEachTileValue1:(NSString*)value;
-(void)setEachTileValue2:(NSString*)value;
-(void)setEachTileValue3:(NSString*)value;
-(void)setEachTileValue4:(NSString*)value;
-(void)setEachTileValue5:(NSString*)value;
-(void)setEachTileNeedleRotationAngle:(float)angle;
-(void)setEachTileAlertImageName:(NSString*)value;
-(void)drawObjects:(CGRect)frame;
@end
