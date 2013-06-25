//
//  WebserviceProcessor.h
//  GreenVolts
//
//  Created by YML on 31/10/11.
//  Copyright (c) 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionData : NSObject 
{
  NSString* m_url;
  NSURLConnection* m_connection;
  NSMutableData* m_responseData;
  BOOL m_bFinishedDownloading;
}

@property (nonatomic, copy) NSString* m_url;
@property (nonatomic, strong) NSURLConnection* m_connection;
@property (nonatomic, readonly) NSMutableData* m_responseData;
@property BOOL m_bFinishedDownloading;

@end

@class WebserviceProcessor;

@protocol WebserviceProcessorDelegate <NSObject>
- (void)onWebserviceProcessorSuccess:(WebserviceProcessor*)processor;
- (void)onWebserviceProcessorError:(WebserviceProcessor*)processor;
@end

@interface WebserviceProcessor : NSObject
{
  NSMutableArray* m_connections;
  id<WebserviceProcessorDelegate> m_delegate;
}

- (id)initWithURLs:(NSArray*)urls delegate:(id<WebserviceProcessorDelegate>)delegate;
- (void)cancel;
- (NSData*)dataForURL:(NSString*)url;

@end
