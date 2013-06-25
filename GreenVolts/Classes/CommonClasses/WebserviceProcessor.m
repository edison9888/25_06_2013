//
//  WebserviceProcessor.m
//  GreenVolts
//
//  Created by YML on 31/10/11.
//  Copyright (c) 2011 YML. All rights reserved.
//

#import "WebserviceProcessor.h"

@implementation ConnectionData 

@synthesize m_connection;
@synthesize m_responseData;
@synthesize m_url;
@synthesize m_bFinishedDownloading;

- (id)init
{
  self = [super init];
  if(self == nil)   return nil;

  m_url = nil;
  m_connection = nil;
  m_responseData = [[NSMutableData alloc] init];
  m_bFinishedDownloading = NO;
  
  return self;
}

- (void)dealloc
{
  if(m_connection)
  {
    [m_connection cancel];
    m_connection=nil;
  }
  if(m_responseData)
  {
    m_responseData=nil;
  }
}

@end

@implementation WebserviceProcessor

- (id)init
{
  assert(false);
  return nil;
}

- (id)initWithURLs:(NSArray*)urls delegate:(id<WebserviceProcessorDelegate>)delegate
{
  self = [super init];
  if(self == nil)  return nil;
  
  m_delegate = delegate;
  m_connections = [[NSMutableArray alloc] init];
  
  for(int i=0; i<[urls count]; ++i)
  {
    ConnectionData* connData = [[ConnectionData alloc] init];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urls objectAtIndex:i]]] delegate:self];
    connData.m_connection = connection;
    
    connData.m_url = [urls objectAtIndex:i];
    
    [m_connections addObject:connData];
    
  }
  
  return self;
}

- (NSData*)dataForURL:(NSString*)url
{
  NSData* responseData = nil;
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    if([connData.m_url compare:url] == NSOrderedSame)
    {
      responseData = [NSData dataWithData:connData.m_responseData];
      break;
    }
  }
  
  return responseData;
}

- (void)cancel
{
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    [connData.m_connection cancel];
  }
  [m_connections removeAllObjects];
  m_delegate=nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    if(connData.m_connection == connection)
    {
      [connData.m_responseData appendData:data];
      break;
    }
  }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
  //  Error Codes: 
  //  10001 – cannot connect to backend systems
  //  10002 – invalid username or password (displays an error message on top of the screen)
  
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    [connData.m_connection cancel];
  }
  [m_connections removeAllObjects];
  [m_delegate onWebserviceProcessorError:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    if(connData.m_connection == connection)
    {
      connData.m_bFinishedDownloading = YES;
      break;
    }
  }
  
  BOOL bAllFinished = YES;
  for(int i=0; i<[m_connections count]; ++i)
  {
    ConnectionData* connData = [m_connections objectAtIndex:i];
    if(connData.m_bFinishedDownloading == NO)
    {
      bAllFinished = NO;
      break;
    }
  }
  
  if(bAllFinished)
  {
    [m_delegate onWebserviceProcessorSuccess:self];
    [m_connections removeAllObjects];
    m_delegate=nil;
  }
}	

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
  return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
  if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    //    if (... user allows connection despite bad certificate ...)
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
  
  //[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
