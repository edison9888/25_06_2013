//
//  TopTileView.h
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVRect.h"

@interface TopTileView : UIView 
{
  UIImageView *m_AlertImageView; //ImageName
  UIImageView *m_PowerProductionNeedleView; //Transform
  UIImageView *m_PVSDNINeedleView; //Transform
  UIImageView *m_WheatherImageView; //ImageName
  
  UILabel *m_TodayKWHValueLabel; //Text
  UILabel *m_DNIVlaueLabel; //Text
  UILabel *m_TimeValueLabel; //Text
  UILabel *m_CurrentKWValueLabel; //Text
  UILabel *m_SiteWeatherDescLabel; //Text
  UILabel *m_WindInfoLabel; //Text
  
  UILabel *m_ValueLabel1; //Text
  UILabel *m_ValueLabel2; //Text
  UILabel *m_ValueLabel3; //Text
  UILabel *m_ValueLabel4; //Text
  UILabel *m_ValueLabel5; //Text
    
  UILabel *m_ModeLabel;
  UILabel *m_OperationalMode;
  GVRect *m_OperationRect;
}

-(void)setCurrentKWValue:(NSString*)value;
-(void)setTopTileAlertImageName:(NSString*)value;
-(void)setTopTilePowerProductionNeedleRotationAngle:(float)angle;
-(void)setTopTilePowerVsDNINeedleRotationAngle:(float)angle;
-(void)setTopTileWeatherImageName:(NSString*)value;
-(void)setTopTileTodayKWH:(NSString*)value;
-(void)setTopTileDNI:(NSString*)value;
-(void)setTopTileTime:(NSString*)value;
-(void)setTopTileWeatherDescription:(NSString*)value;
-(void)setTopTileWindInfo:(NSString*)value;
-(void)setTopTileValue1:(NSString*)value;
-(void)setTopTileValue2:(NSString*)value;
-(void)setTopTileValue3:(NSString*)value;
-(void)setTopTileValue4:(NSString*)value;
-(void)setTopTileValue5:(NSString*)value;
-(void)setOperationalMode:(NSString*)value;
-(void)hideOperationMode:(BOOL)hide;
@end
