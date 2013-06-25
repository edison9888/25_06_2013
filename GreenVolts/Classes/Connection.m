//
//  Connection.m
//  GreenVolts
//
//  Created by YML on 10/13/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "Connection.h"
#import "SBJson.h"
#import "CommonClasses/NSData+GVBlowfish.h"

//static Connection *mConnection =nil;

@implementation Connection
@synthesize m_delegate;

-(id)init
{
  if(self = [super init])
  {
    mURLConnection=nil;
    mResponseData=nil;
  }
    
  return self;
}

-(void)dealloc
{
  m_delegate=nil;
  if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
	if(mResponseData)
	{
		mResponseData=nil;
	}  
  
}

#pragma mark URLConnectionManager Methods

-(void)connectToServer
{      
	if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
  if(mResponseData)
	{
		mResponseData=nil;
	}
  
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  
  NSString *pUsername=[[NSUserDefaults standardUserDefaults]objectForKey:@"USERNAME"];
  NSString *pPassword=[[[NSUserDefaults standardUserDefaults]objectForKey:@"PASSWORD"] decryptAsDES];
  
  [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetUserInfo?username=%@&password=%@",kserverAddress,[pUsername stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[pPassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
  //printf("\nConnect To server:%s\n",[[request description] UTF8String]);
	[request setHTTPMethod:@"GET"];
	mURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	if(mResponseData == nil)
		mResponseData = [[NSMutableData alloc] init];
	[mResponseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
	if(mResponseData != nil)
		[mResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
  //  Error Codes: 
  //  10001 – cannot connect to backend systems
  //  10002 – invalid username or password (displays an error message on top of the screen)  
  if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
	if(mResponseData)
	{
		mResponseData=nil;
	}
  if(m_delegate && [m_delegate respondsToSelector:@selector(ConnectionFailed)])
    [m_delegate ConnectionFailed];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{  
	if(mURLConnection) 
	{
		[mURLConnection cancel];

		mURLConnection=nil;
	}
  
  [self jsonParser];
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

-(void)jsonParser
{
  // parsing the first level    
  
  NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
  
  //printf("\nResponse in Connection:%s\n",[responseString UTF8String]);
  
  NSDictionary *data=[responseString JSONValue];
  
  NSDictionary *userResult= [data objectForKey:@"GetUserInfoResult"]; 
  
  NSArray *rootResult = [userResult objectForKey:@"RootResults"];
  
  if([rootResult count])
  {
    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
    
    NSObject *sessionToken=[rootResultDict objectForKey:@"SessionToken"];
    
    if([sessionToken isKindOfClass:[NSNull class]])
    {
      NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
      if([errorId intValue]==10002)
      {
        if(m_delegate && [m_delegate respondsToSelector:@selector(InvalidUserNameError:)])
        [m_delegate InvalidUserNameError:1];
      }
      else if([errorId intValue]==10001)
      {
        if(m_delegate && [m_delegate respondsToSelector:@selector(InvalidUserNameError:)])
          [m_delegate InvalidUserNameError:0];
      }
    }
    else 
    {
      [[NSUserDefaults standardUserDefaults]setObject:sessionToken forKey:@"SESSION_TOKEN"];
        if(m_delegate && [m_delegate respondsToSelector:@selector(Success)])
        [m_delegate Success];
    }
  }
  if(mResponseData)
	{
		mResponseData=nil;
	}  
}
-(void)setM_delegate:(id<ConnectionDelegate>)delegate
{
  if(delegate==nil)
  {
    if(mURLConnection) 
    {
      [mURLConnection cancel];
      mURLConnection=nil;
    }
    if(mResponseData)
    {
      mResponseData=nil;
    }
    m_delegate=nil;
  }
  else
    m_delegate=delegate;
}
@end
