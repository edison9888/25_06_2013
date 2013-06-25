//
//  String.m
//  GreenVolts
//
//  Created by YML on 9/20/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "String.h"


@implementation String
@synthesize m_StringId,AlarmCount,ArrayCount,m_CurrentDNI,m_CurrentPower,m_Location,m_Name,m_Temperature,m_WindDirection,m_WindSpeed,m_LocalDateTime, StringCount,
m_TodayEnergy,m_UTCDateTime,m_UTCOffset,m_WeatherStatus,m_WeatherIcon,m_YTDEnergy;

-(id)init
{
  if( self = [super init])
  {
    AlarmCount=0;
    ArrayCount=0;
    StringCount=0;
    m_StringId=nil;
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
  }
  return self;
}
-(void)dealloc
{
//  //printf("Dealloc called in String\n");
}
-(NSString*)description
{
  NSMutableString *desc=[NSMutableString stringWithFormat:@""];
  [desc appendFormat:@"AlarmCount:%d\n",AlarmCount];
  [desc appendFormat:@"ArrayCount:%d\n",ArrayCount];
  
  [desc appendFormat:@"m_StringId:%@\n",m_StringId];
  
  [desc appendFormat:@"m_CurrentDNI:%@\n",m_CurrentDNI];
  [desc appendFormat:@"m_TodayEnergy:%@\n",m_TodayEnergy];
  [desc appendFormat:@"m_YTDEnergy:%@\n",m_YTDEnergy];
  
  [desc appendFormat:@"m_CurrentPower:%@\n",m_CurrentPower];
  [desc appendFormat:@"m_Location:%@\n",m_Location];
  [desc appendFormat:@"m_Name:%@\n",m_Name];
  [desc appendFormat:@"m_Temperature:%@\n",m_Temperature];
  [desc appendFormat:@"m_WindDirection:%@\n",m_WindDirection];
  [desc appendFormat:@"m_WindSpeed:%@\n",m_WindSpeed];
  [desc appendFormat:@"m_UTCDateTime:%@\n",m_UTCDateTime];
  [desc appendFormat:@"m_UTCOffset:%@\n",m_UTCOffset];
  [desc appendFormat:@"m_LocalDateTime:%@\n",m_LocalDateTime];
  [desc appendFormat:@"m_WeatherStatus:%@\n",m_WeatherStatus];
  [desc appendFormat:@"m_WeatherIcon:%@\n",m_WeatherIcon];
  return desc;
}
@end
