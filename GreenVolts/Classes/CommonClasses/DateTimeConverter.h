//
//  DateTimeConverter.h
//  GreenVolts
//
//  Created by YML on 10/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTimeConverter : NSObject
+(NSString*)getActualTimeStringFrom:(NSString*)epochTime;
+(NSDate*)getActualDateFrom:(NSString*)epochTime;
+(NSDate*)getCorrectDateWithRespectToObect:(NSObject*)object;
@end
