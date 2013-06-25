//
//  CameraView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "CameraView.h"
#import "SBJson.h"
#import "LoginManager.h"
#import <QuartzCore/QuartzCore.h>
@interface CameraView(PVT)<LoginManagerDelegate>
-(void)jsonParser;
-(void)connectToServer;
@end

@implementation CameraView
@synthesize m_deleagte,isVisible;
- (id)initWithFrame:(CGRect)frame CameraID:(int)pCameraId
{    
    self = [super initWithFrame:frame];
    if (self) 
    {
      mCameraId=pCameraId;
      self.backgroundColor=[UIColor blackColor];
      m_ImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,-4, 297,225)];
      m_ImageView.userInteractionEnabled=YES;
      m_ImageView.multipleTouchEnabled=YES;  
      m_ImageView.contentMode=UIViewContentModeScaleAspectFit;
      m_ImageView.clipsToBounds=YES;  
        
      [self addSubview:m_ImageView];
      
      [self connectToServer];
      
      m_Timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(reloadImage) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)reloadImage
{
  if(isVisible)
  {
  if(!isConnection)
    [self connectToServer];
  }
}

#pragma mark URLConnectionManager Methods

-(void)connectToServer
{
  [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ERROR"];
  isConnection=YES;
  
	if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
  if(mResponseData)
	{
		mResponseData=nil;
	}
  
  NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
  
	mURLConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetCameraImage?sessionToken=%@&cameraID=%d",kserverAddress,pSessionToken,mCameraId]]] delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
  if(!mResponseData)
    mResponseData=[NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
  [mResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
  isConnection=NO;
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(mURLConnection) 
	{
		mURLConnection=nil;
	}
  isConnection=NO;
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
  //NSMutableData
   NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
  mResponseData=nil;
  
  //printf("\nJson String:%s\n",[responseString UTF8String]);
  NSDictionary *data=[responseString JSONValue];
  
  NSDictionary *userResult= [data objectForKey:@"GetCameraImageResult"]; 
  
  NSArray *rootResult = [userResult objectForKey:@"RootResults"];
  
  if([rootResult count])
  {
    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
    
    NSObject *error=[rootResultDict objectForKey:@"Err"];
    
    if([error isKindOfClass:[NSNull class]])
    {
        NSDictionary *imageDictinary=[rootResult objectAtIndex:0];
        NSArray *pImageDataArray=[imageDictinary objectForKey:@"CameraImage"];
        if(![pImageDataArray isKindOfClass:[NSNull class]])
        {
          NSMutableData* pictureData = [[NSMutableData alloc] init];
          for(int i=0;i<[pImageDataArray count];i++)
          {
            unsigned char ch = [[pImageDataArray objectAtIndex:i] charValue];
            
            [pictureData appendBytes:&ch length:1];
          }
          m_ImageView.image=[UIImage imageWithData:pictureData];
        }          
    }
    else 
    {
      NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
      if([errorId intValue]==10002 || [errorId intValue]==10026 || [errorId intValue]==10028 || [errorId intValue]==10029)
        [[LoginManager sharedLoginManagerWithDelegate:self] ShowLoginPage];
      if(![[NSUserDefaults standardUserDefaults]boolForKey:@"ERROR"])
      {
        if([errorId intValue]!=10003)
        {
          UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:[rootResultDict objectForKey:@"Err"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
          [pAlert show];
          pAlert=nil;    
        }
      }
      if([errorId intValue]==10003)
      {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ERROR"];
        if(m_deleagte && [m_deleagte respondsToSelector:@selector(fetchSessionTokenforCamera)])
          [m_deleagte fetchSessionTokenforCamera];
      }            
    }
  }
}

-(void)cleanUp
{
  m_deleagte=nil;
  if(m_ImageView){[m_ImageView removeFromSuperview];}
  if(m_Timer)
  {
    [m_Timer invalidate];
    m_Timer=nil;
  }
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
- (void)dealloc 
{
  //printf("Dealloc in Camera View\n");
  m_deleagte=nil;
  if(m_ImageView){[m_ImageView removeFromSuperview];}
  if(m_Timer)
  {
    [m_Timer invalidate];
    m_Timer=nil;
  }
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


@end
