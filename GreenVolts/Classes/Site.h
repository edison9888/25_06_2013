//
//  Site.h
//  GreenVolts
//
//  Created by YML on 9/19/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Site : NSObject

@property(nonatomic,assign) int AlarmCount;
@property(nonatomic,assign) int ArrayCount;
@property(nonatomic,assign) int totalCount;
@property(nonatomic,assign) int CameraID;
@property(nonatomic,assign) int SectionCount;
@property(nonatomic,strong) NSString *m_SiteId;
@property(nonatomic,strong) NSNumber *m_CurrentDNI;
@property(nonatomic,strong) NSString *m_CurrentPower;
@property(nonatomic,strong) NSString *m_Location;
@property(nonatomic,strong) NSString *m_Name;
@property(nonatomic,strong) NSString *m_Temperature;
@property(nonatomic,strong) NSString *m_WindDirection;
@property(nonatomic,strong) NSString *m_WindSpeed;
@property(nonatomic,strong) NSNumber *m_TodayEnergy;
@property(nonatomic,strong) NSString *m_UTCDateTime;
@property(nonatomic,strong) NSString *m_UTCOffset;
@property(nonatomic,strong) NSString *m_WeatherStatus;
@property(nonatomic,strong) NSString *m_WeatherIcon;
@property(nonatomic,strong) NSNumber *m_YTDEnergy;
@property(nonatomic,strong) NSString *m_LocalDateTime;

@property(nonatomic,strong) NSArray *m_SectionArray;
@end
