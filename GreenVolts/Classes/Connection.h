//
//  Connection.h
//  GreenVolts
//
//  Created by YML on 10/13/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionFailedDelegate.h"

@protocol ConnectionDelegate<NSObject>

-(void)ConnectionFailed;
-(void)InvalidUserNameError:(int)errorIndex;
-(void)Success;

@end


@interface Connection : NSObject 
{
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
}

//+(Connection *)sharedConnection;
-(void)jsonParser;
-(void)connectToServer;
@property(nonatomic,assign) id <ConnectionDelegate> m_delegate;
@end
