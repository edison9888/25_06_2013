//
//  SliderManager.h
//  GreenVolts
//
//  Created by YML on 21/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderManager : NSObject
+(SliderManager*)SharedSliderManager;
-(void)handleSlider:(UISlider*)slider andIsDailyGraph:(BOOL)bGraphTypeDaily withRespectToObject:(NSObject*)object;
-(void)updateSlider:(UISlider*)slider andIsDailyGraph:(BOOL)bGraphTypeDaily;
@end
