//
//  EntityDetails.m
//  GreenVolts
//
//  Created by YML on 9/22/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "EntityDetails.h"


@implementation EntityDetails

@synthesize m_DNI,m_DateTimeLocal,m_Energy,m_Power,m_WindDirection,m_WindSpeed;

-(id)init
{
  if(self = [super init])
  {
    m_DNI=nil;
    m_DateTimeLocal=nil;
    m_Energy=nil;
    m_Power=nil;
    m_WindDirection=nil;
    m_WindSpeed=nil;
  }
  return self;
}

-(NSString*)description
{
  NSMutableString *desc=[NSMutableString stringWithFormat:@"m_DNI:%@\n",m_DNI];
  [desc appendFormat:@"m_DateTimeLocal:%@",m_DateTimeLocal];
  [desc appendFormat:@"m_Energy:%@",m_Energy];
  [desc appendFormat:@"m_Power:%@",m_Power];
  [desc appendFormat:@"m_WindDirection:%@",m_WindDirection];
  [desc appendFormat:@"m_WindSpeed:%@",m_WindSpeed];
  return desc;
}

@end
