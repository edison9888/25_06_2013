//
//  AccelerometerObserver.h
//
//  Created by YML on 24/04/11.
//  Copyright 2010 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccelerometerObserverDelegate

-(void)showResult;

@end




@interface AccelerometerObserver : NSObject <UIAccelerometerDelegate>
{
	float  accX,accY,accZ;
	int m_stationaryCount;
	int m_movingCount;
	int m_count;
	bool m_starObserving,shakeDetected;
	int m_TimeLimit;
}

@property(nonatomic,assign)	id<AccelerometerObserverDelegate> m_delegate;
@property(nonatomic,strong)  UIAcceleration *lastAcceleration;
-(id)initWithTimeGap:(int)time;
-(void)startObseving;
-(void)stopObesrving;

@end
