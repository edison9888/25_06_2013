//
//  SiteDisplayTableViewCell.m
//  GreenVolts
//
//  Created by YML on 25/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "SiteDisplayTableViewCell.h"
#import "SiteListTileView.h"
#import "Site.h"
#import "DateTimeConverter.h"
@implementation SiteDisplayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) 
  {
    siteTile=[[SiteListTileView alloc]initWithFrame:CGRectMake(24,5, 272, 157)];
    [self addSubview:siteTile];
    
    frmtr = [[NSNumberFormatter alloc] init];
    [frmtr setGroupingSize:3];
    [frmtr setGroupingSeparator:@","];
    [frmtr setUsesGroupingSeparator:YES];
  }
  return self;
}
-(void)displayDataFor:(Site*)site
{
  [siteTile setSiteName:site.m_Name];
  [siteTile setSiteLocation:site.m_Location];
  if(site.m_Temperature != NULL)
  {
    float temp=[site.m_Temperature floatValue];
    [siteTile setSiteTemperature:[NSString stringWithFormat:@"%2.0  f°C",temp]];
  }
  else 
  {
    [siteTile setSiteTemperature:@""]; 
  }
  
  [siteTile setSiteWeatherDescription:site.m_WeatherStatus];
  
  [siteTile setSiteDNILevel:[frmtr stringFromNumber:site.m_CurrentDNI]];
  [siteTile setSiteTodayEP:[frmtr stringFromNumber:site.m_TodayEnergy]];
  [siteTile setSiteYesterdayEP:[frmtr stringFromNumber:site.m_YTDEnergy]];
  
  
  if(site.AlarmCount==0)
    [siteTile setSiteAlertImageName:@"Alert-Green.png"];
  else 
    [siteTile setSiteAlertImageName:@"Alert-red.png"];
  
  NSString *pIconName=[NSString stringWithFormat:@"%@.png",site.m_WeatherIcon];
  [siteTile setSiteWeatherImageName:pIconName];
  
  float scale;
  scale=site.ArrayCount*16;
  int range=ceil(scale/4.0);
  
  [siteTile setSiteValue1:[NSString stringWithFormat:@"%d",range*0]];
  [siteTile setSiteValue2:[NSString stringWithFormat:@"%d",range*1]];
  [siteTile setSiteValue3:[NSString stringWithFormat:@"%d",range*2]];
  [siteTile setSiteValue4:[NSString stringWithFormat:@"%d",range*3]];
  [siteTile setSiteValue5:[NSString stringWithFormat:@"%d",range*4]];
     
  
  [siteTile decreasePowerLabelSize:range*4];      
  
  
  if([site.m_CurrentPower floatValue]<=scale/2)
  {
    float angle=((112.0)*([site.m_CurrentPower floatValue]))/(scale/2); 
    float rotationAngle=248.0+angle;                                        //252
    [siteTile setPowerNeedleRotationAngle:(rotationAngle*0.0174532925)];
  }
  else 
  {
    float angle=((112.0)*([site.m_CurrentPower floatValue]-(scale/2)))/(scale/2);
    [siteTile setPowerNeedleRotationAngle:(angle*0.0174532925)];
  }
  
  if([site.m_CurrentDNI floatValue]<=600)
  {
    float angle=((107.0)*([site.m_CurrentDNI floatValue]))/600.0;
    float rotationAngle=252.0+angle;
    [siteTile setDNINeedleRotationAngle:(rotationAngle*0.0174532925)];      
  }
  else 
  {
    float angle=((107.0)*([site.m_CurrentDNI floatValue]-600.0))/600.0;
    [siteTile setDNINeedleRotationAngle:(angle*0.0174532925)];            
  }
  
  [siteTile setSiteTime:[NSString stringWithFormat:@"%@",[DateTimeConverter getActualTimeStringFrom:site.m_LocalDateTime]]];
}
@end
