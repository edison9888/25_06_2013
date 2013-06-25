//
//  AccelerometerObserver.m
//  accelerometerdummy
//
//  Created by YML on 24/04/11.
//  Copyright 2010 company. All rights reserved.
//

#import "AccelerometerObserver.h"

static BOOL IsDeviceShaking(UIAcceleration* last, UIAcceleration* current, double threshold)
{
  double deltaX = fabs(last.x - current.x);
  double deltaY = fabs(last.y - current.y);
  double deltaZ = fabs(last.z - current.z);
  return (deltaX > threshold && deltaY > threshold) ||
  (deltaX > threshold && deltaZ > threshold) ||
  (deltaY > threshold && deltaZ > threshold);
}

@implementation AccelerometerObserver

@synthesize m_delegate,lastAcceleration;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithTimeGap:(int)time
{
	if(self = [super init])		
	{
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/5];
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];		
		accX = 0;
		accY = 0;
		accZ = 0;				
		m_stationaryCount = 0;
		m_movingCount = 0;
		m_count = 0;
		m_starObserving = FALSE ;
    shakeDetected=FALSE;
		m_TimeLimit = time;
    m_delegate = nil;
	}
	return self;
}

-(void)setDelegate:(id<AccelerometerObserverDelegate>)observer
{
	m_delegate = observer;
}

-(void)startObseving
{
	accX = 0;
	accY = 0;
	accZ = 0;		
	m_stationaryCount = 0;
	m_count = 0;	
	m_starObserving = TRUE;
}

-(void)stopObesrving
{
	m_starObserving = FALSE;
}

- (void) accelerometer: (UIAccelerometer *)accelerometer didAccelerate: (UIAcceleration *)acceleration {
  if (self.lastAcceleration) {
    if (!shakeDetected && IsDeviceShaking(self.lastAcceleration, acceleration, 0.7)) {
      shakeDetected = YES;
      [m_delegate showResult];
      //SHAKE DETECTED. WRITE YOUR CODE HERE.
    } else if (shakeDetected && !IsDeviceShaking(self.lastAcceleration, acceleration, 0.2)) {
      shakeDetected = NO;
    }
  }
  self.lastAcceleration = acceleration; 
}


- (void)dealloc 
{
  [[UIAccelerometer sharedAccelerometer] setDelegate:nil];	 
}


@end
