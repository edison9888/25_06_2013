//
//  DateTimeConverter.m
//  GreenVolts
//
//  Created by YML on 10/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "DateTimeConverter.h"
#import "Site.h"
#import "Section.h"
#import "Array.h"
#import "String.h"
@implementation DateTimeConverter
+(NSString*)getActualTimeStringFrom:(NSString*)epochTime
{
  //epochTime: /Date(1320918970748-0800)/
  //epochTime: /Date(1320918970748)/
  NSString *actualTime=nil;
  NSString *str=[epochTime stringByReplacingOccurrencesOfString:@"/" withString:@""];
  NSString *str1=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
  str1=[str1 stringByReplacingOccurrencesOfString:@")" withString:@""];
  str1=[str1 stringByReplacingOccurrencesOfString:@"Date" withString:@""];
  NSArray *pArr1=[str1 componentsSeparatedByString:@"-"];
  
  double seconds=0;
  double milliSeconds1=0;
  double seconds2beSubtracted=0;
  //If offset is provided
  if([pArr1 count]>=1)
  {
    NSString *date=[pArr1 objectAtIndex:0];
    milliSeconds1=[date doubleValue];
    seconds=milliSeconds1/1000;
    
    NSString *offset=[pArr1 objectAtIndex:1];
    NSString *hourOffset=[offset substringToIndex:2];
    NSString *minOffset=[offset substringFromIndex:2];
    seconds2beSubtracted=([hourOffset intValue]*3600)+([minOffset intValue]*60);
  }
  else
  {
    milliSeconds1=[str1 doubleValue];
    seconds=milliSeconds1/1000;
  }
  
  NSDate *pDate=[NSDate dateWithTimeIntervalSince1970:seconds-seconds2beSubtracted];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
  [formatter setTimeZone:gmt];
  [formatter setDateFormat:@"h:mm a"];
  
  //Optionally for time zone converstions    
  actualTime = [formatter stringFromDate:pDate];
  return actualTime;
}
+(NSDate*)getActualDateFrom:(NSString*)epochTime
{
  //epochTime: /Date(1320918970748-0800)/
  //epochTime: /Date(1320918970748)/
  NSDate *actualDate=nil;
  NSString *str=[epochTime stringByReplacingOccurrencesOfString:@"/" withString:@""];
  NSString *str1=[str stringByReplacingOccurrencesOfString:@"(" withString:@""];
  str1=[str1 stringByReplacingOccurrencesOfString:@")" withString:@""];
  str1=[str1 stringByReplacingOccurrencesOfString:@"Date" withString:@""];
  NSArray *pArr1=[str1 componentsSeparatedByString:@"-"];
  
  double seconds=0;
  double milliSeconds1=0;
  double seconds2beSubtracted=0;
  //If offset is provided
  if([pArr1 count]>=1)
  {
    NSString *date=[pArr1 objectAtIndex:0];
    milliSeconds1=[date doubleValue];
    seconds=milliSeconds1/1000;
    
    NSString *offset=[pArr1 objectAtIndex:1];
    NSString *hourOffset=[offset substringToIndex:2];
    NSString *minOffset=[offset substringFromIndex:2];
    seconds2beSubtracted=([hourOffset intValue]*3600)+([minOffset intValue]*60);
  }
  else
  {
    milliSeconds1=[str1 doubleValue];
    seconds=milliSeconds1/1000;
  }
  
  NSDate *pDate=[NSDate dateWithTimeIntervalSince1970:seconds-seconds2beSubtracted];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
  [formatter setTimeZone:gmt];
  [formatter setDateFormat:@"hh:mm a"];
  
  //Optionally for time zone converstions    
  actualDate=pDate;
  return actualDate;
}
+(NSDate*)getCorrectDateWithRespectToObect:(NSObject*)object
{  
  NSDate *currentStartDate=[NSDate date];
  
  if([object isKindOfClass:[Site class]])
  {
    Site *site=(Site *)object;
    NSDate *siteDate=[DateTimeConverter getActualDateFrom:site.m_LocalDateTime];
//    if([currentStartDate timeIntervalSinceDate:siteDate]>0)
      currentStartDate=siteDate;
  }
  else if([object isKindOfClass:[Section class]])
  {
    Section *section=(Section *)object;
    NSDate *sectionDate=[DateTimeConverter getActualDateFrom:section.m_LocalDateTime];
  //  if([currentStartDate timeIntervalSinceDate:sectionDate]>0)
      currentStartDate=sectionDate;
  }
  else if([object isKindOfClass:[Array class]])
  {
    Array *array=(Array *)object;
    NSDate *arrayDate=[DateTimeConverter getActualDateFrom:array.m_LocalDateTime];
    //if([currentStartDate timeIntervalSinceDate:arrayDate]>0)
      currentStartDate=arrayDate;
  }
  else if([object isKindOfClass:[String class]])
  {
    String *string=(String *)object;
    NSDate *stringDate=[DateTimeConverter getActualDateFrom:string.m_LocalDateTime];
//    if([currentStartDate timeIntervalSinceDate:stringDate]>0)
      currentStartDate=stringDate;
  }  
  return currentStartDate;
}

@end
