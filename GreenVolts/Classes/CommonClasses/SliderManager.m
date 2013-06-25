//
//  SliderManager.m
//  GreenVolts
//
//  Created by YML on 21/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "SliderManager.h"
#import "DateTimeConverter.h"

static SliderManager *_instance=nil;
@implementation SliderManager
+(SliderManager*)SharedSliderManager
{
  if(!_instance)
    _instance=[[SliderManager alloc]init];
  return _instance;
}
-(void)handleSlider:(UISlider*)slider andIsDailyGraph:(BOOL)bGraphTypeDaily withRespectToObject:(NSObject*)object
{
  /// Get current selected Date
  
  int minThreshold = 2;
  int maxThreshold = 13;
  if(bGraphTypeDaily == NO)
  {
    minThreshold = 2;
    maxThreshold = 20;
  }
  
  NSDate *correctDate=[DateTimeConverter getCorrectDateWithRespectToObect:object];
  
  NSDate* oldSelectedDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSelectedDateKey];
  
  if(slider.value == slider.maximumValue)
  {
    [[NSUserDefaults standardUserDefaults] setObject:correctDate forKey:kCurrentSelectedDateKey];
    [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*14] forKey:kDailyStartDateKey];
    [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*21] forKey:kWeeklyStartDateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
  else
  {
    NSDate* dailyGraphStartDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kDailyStartDateKey];
    NSDate* weeklyGraphStartDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kWeeklyStartDateKey];
    
    if(bGraphTypeDaily)
    {
      NSDate* newCurrentSelectedDate = [dailyGraphStartDate dateByAddingTimeInterval:(24*60*60)*slider.value+1];
      [[NSUserDefaults standardUserDefaults] setObject:newCurrentSelectedDate forKey:kCurrentSelectedDateKey];
      [[NSUserDefaults standardUserDefaults] synchronize];
      if(slider.value <= minThreshold)
      {          
        [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(14/2)] forKey:kDailyStartDateKey];
        
        slider.value = 14/2;
      }
      else
        if(slider.value > maxThreshold)
        {
          if([oldSelectedDate timeIntervalSinceDate:newCurrentSelectedDate] < 0) /// This checks the direction of swipe
          {
            if([correctDate timeIntervalSinceDate:newCurrentSelectedDate] > (24*60*60)*(14/2))
            {
              newCurrentSelectedDate = [dailyGraphStartDate dateByAddingTimeInterval:(24*60*60)*14];
              [[NSUserDefaults standardUserDefaults] setObject:newCurrentSelectedDate forKey:kCurrentSelectedDateKey];
              [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(14/2)] forKey:kDailyStartDateKey];
              [[NSUserDefaults standardUserDefaults] synchronize];
              slider.value = 14/2;
            }
            else
            {
              [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*(14-(abs(slider.value)))] forKey:kCurrentSelectedDateKey];
              [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*14] forKey:kDailyStartDateKey];
              [[NSUserDefaults standardUserDefaults] synchronize];
              slider.value = 14-(14-(abs(slider.value)));
            }
          }
        }
      
      if([newCurrentSelectedDate timeIntervalSinceDate:weeklyGraphStartDate] < (24*60*60)*4)
        [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(21/2)] forKey:kWeeklyStartDateKey];
      else
        if([correctDate timeIntervalSinceDate:newCurrentSelectedDate] > (24*60*60)*21/2 && ([oldSelectedDate timeIntervalSinceDate:newCurrentSelectedDate] < 0))
          [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(21/2)] forKey:kWeeklyStartDateKey];
        else
          [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*21] forKey:kWeeklyStartDateKey];
    }
    else
    {
      NSDate* newCurrentSelectedDate = [weeklyGraphStartDate dateByAddingTimeInterval:(24*60*60)*slider.value+1];
      [[NSUserDefaults standardUserDefaults] setObject:newCurrentSelectedDate forKey:kCurrentSelectedDateKey];
      [[NSUserDefaults standardUserDefaults] synchronize];
      if(slider.value <= minThreshold)
      {
        [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(21/2)] forKey:kWeeklyStartDateKey];
        
        slider.value = 21/2;
      }
      else
        if(slider.value > maxThreshold)
        {
          if([oldSelectedDate timeIntervalSinceDate:newCurrentSelectedDate] < 0) /// This checks the direction of swipe
          {
            if([correctDate timeIntervalSinceDate:newCurrentSelectedDate] > (24*60*60)*(21/2))
            {
              newCurrentSelectedDate = [dailyGraphStartDate dateByAddingTimeInterval:(24*60*60)*21];
              [[NSUserDefaults standardUserDefaults] setObject:newCurrentSelectedDate forKey:kCurrentSelectedDateKey];
              [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(21/2)] forKey:kWeeklyStartDateKey];
              [[NSUserDefaults standardUserDefaults] synchronize];
              slider.value = 21/2;
            }
            else
            {
              [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*(21-(abs(slider.value)))] forKey:kCurrentSelectedDateKey];
              [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*21] forKey:kWeeklyStartDateKey];
              slider.value = 21-(21-(abs(slider.value)));
              [[NSUserDefaults standardUserDefaults] synchronize];
            }
          }
        }    
      
      if([newCurrentSelectedDate timeIntervalSinceDate:dailyGraphStartDate] < (24*60*60)*3)
        [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(14/2)] forKey:kDailyStartDateKey];
      else
        if([correctDate timeIntervalSinceDate:newCurrentSelectedDate] > (24*60*60)*14/2 && ([oldSelectedDate timeIntervalSinceDate:newCurrentSelectedDate] < 0))
          [[NSUserDefaults standardUserDefaults] setObject:[newCurrentSelectedDate dateByAddingTimeInterval:-(24*60*60)*(14/2)] forKey:kDailyStartDateKey];
        else
          [[NSUserDefaults standardUserDefaults] setObject:[correctDate dateByAddingTimeInterval:-(24*60*60)*14] forKey:kDailyStartDateKey];
    }
  }  
}
-(void)updateSlider:(UISlider*)slider andIsDailyGraph:(BOOL)bGraphTypeDaily
{
  /// Find max, min value of slider
  
  /// Get current selected Date
  NSDate* currentSelectedDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kCurrentSelectedDateKey];
  
  /// Set slider values;
  slider.minimumValue = 1;
  if(bGraphTypeDaily)
  {
    slider.maximumValue = 14;
    NSDate* graphStartDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kDailyStartDateKey];
    
    slider.value = round(fabs((double)[graphStartDate timeIntervalSinceDate:currentSelectedDate]/(double)(24*60*60)));
  }
  else
  {
    slider.maximumValue = 21;
    NSDate* graphStartDate = (NSDate*)[[NSUserDefaults standardUserDefaults] objectForKey:kWeeklyStartDateKey];
    
    slider.value = round(fabs((double)[graphStartDate timeIntervalSinceDate:currentSelectedDate]/(double)(24*60*60)));
  }
}
@end
