//
//  Site.m
//  GreenVolts
//
//  Created by YML on 9/19/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "Site.h"


@implementation Site

@synthesize m_SiteId,AlarmCount,ArrayCount,totalCount,CameraID,m_CurrentDNI,m_CurrentPower,m_Location,m_Name,m_Temperature,m_WindDirection,m_WindSpeed,m_LocalDateTime,
m_TodayEnergy,m_UTCDateTime,m_UTCOffset,m_WeatherStatus,m_WeatherIcon,m_YTDEnergy,m_SectionArray;
@synthesize SectionCount;
-(id)init
{
  if( self = [super init])
  {
    AlarmCount=0;
    ArrayCount=0;
    totalCount=0;
    CameraID=0;
    m_SiteId=nil;
    m_CurrentDNI=nil;
    m_CurrentPower=nil;
    m_Location=nil;
    m_Name=nil;
    m_Temperature=nil;
    m_WindDirection=nil;
    m_WindSpeed=nil;
    m_TodayEnergy=nil;
    m_UTCDateTime=nil;
    m_UTCOffset=nil;
    m_WeatherStatus=nil;
    m_WeatherIcon=nil;
    m_YTDEnergy=nil;
    m_LocalDateTime=nil;
    SectionCount=0;
    m_SectionArray=nil;
  }
  return self;
}
-(void)dealloc
{
//  //printf("Dealloc called in Site\n");
}
-(NSString*)description
{
  NSMutableString *desc=[NSMutableString stringWithFormat:@"AlarmCount:%d\n",AlarmCount];
  [desc appendFormat:@"SectionCount:%d\n",SectionCount];
  [desc appendFormat:@"ArrayCount:%d\n",ArrayCount];
  [desc appendFormat:@"TotalCount:%d\n",totalCount];
  [desc appendFormat:@"CameraID:%d\n",CameraID];
  [desc appendFormat:@"SiteID:%@\n",m_SiteId];
  [desc appendFormat:@"CurrentDNI:%@",m_CurrentDNI];
  [desc appendFormat:@"TodayEnergy:%@",m_TodayEnergy];
  [desc appendFormat:@"YTDEnergy:%@",m_YTDEnergy];
  [desc appendFormat:@"CurrentPower:%@",m_CurrentPower];
  [desc appendFormat:@"Location:%@",m_Location];
  [desc appendFormat:@"Name:%@",m_Name];
  [desc appendFormat:@"Temprature:%@",m_Temperature];
  [desc appendFormat:@"WindDirection:%@",m_WindDirection];
  [desc appendFormat:@"WindSpeed:%@",m_WindSpeed];
  [desc appendFormat:@"UTCDateTime:%@",m_UTCDateTime];
  [desc appendFormat:@"UTCOffset:%@",m_UTCOffset];
  [desc appendFormat:@"LocalDBTime:%@",m_LocalDateTime];
  [desc appendFormat:@"WeatherStatus:%@",m_WeatherStatus];
  [desc appendFormat:@"WeatherIcon:%@",m_WeatherIcon];
  [desc appendFormat:@"SectionArray:\n%@\n",m_SectionArray];
  return desc;
}
@end
