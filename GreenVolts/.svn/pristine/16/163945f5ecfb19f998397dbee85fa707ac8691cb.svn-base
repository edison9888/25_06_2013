//
//  NewConnection.h
//  GreenVolts
//
//  Created by YML on 11/11/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionFailedDelegate.h"

@protocol NewConnectionDelegate<NSObject>

-(void)ConnectionFailed;
-(void)InvalidUserNameError:(int)errorIndex;
-(void)Success;

@end


@interface NewConnection : NSObject 
{
  NSURLConnection *mURLConnection;
  NSMutableData *mResponseData;
  id <NewConnectionDelegate> _delegate;
}

//+(Connection *)sharedConnection;
-(void)jsonParser;
-(void)connectToServer;
@property(nonatomic,assign) id <NewConnectionDelegate> m_delegate;
@end
