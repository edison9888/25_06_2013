//
//  DataPrefetcher.h
//  GreenVolts
//
//  Created by YML on 19/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewConnection.h"
@protocol DataPrefetcherDelegate;

@interface DataPrefetcher : NSObject<NewConnectionDelegate>
{
  NSURLConnection *mConnection;
  NSMutableData *buffer;
  NSObject *currentObject;
  NewConnection *mAuthenticationConnection;
}
@property(nonatomic,assign)id<DataPrefetcherDelegate> delegate;
-(void)GetClassToBeJumpedFrom:(NSObject*)CurrentObject;
-(void)CancelConnection;
@end

@protocol DataPrefetcherDelegate <NSObject>
-(void)dataPrefetcher:(DataPrefetcher*)dataPrefetcher decidedToJumpToObject:(NSObject*)object;
-(void)dataPrefetcherFoundMissingToken:(DataPrefetcher *)dataPrefetcher;
-(void)dataPrefetcherFoundInternetError:(DataPrefetcher*)dataPrefetcher;
@end