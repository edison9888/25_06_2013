//
//  TrackerView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "TrackerView.h"
#import "Tracker.h"
#import "SBJson.h"
#import "LoginManager.h"
@interface TrackerView(PVT)<LoginManagerDelegate>
-(void)connectToServer;
-(void)jsonParser;
@end


@implementation TrackerView
@synthesize m_delegate;

- (id)initWithFrame:(CGRect)frame 
{    
  self = [super initWithFrame:frame];
  if (self) 
  {
    UIImageView *pBGImageView=[[UIImageView alloc]initWithFrame:CGRectMake(18, 30, 271, 204)];
    pBGImageView.image=[UIImage imageNamed:@"TrackerBG.png"];
    [self addSubview:pBGImageView];
    
    m_Tilt1Tracker=[[UIImageView alloc]initWithFrame:CGRectMake(132, 27, 12, 10)];
    m_Tilt1Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];
    [self addSubview:m_Tilt1Tracker];
    
    m_Tilt2Tracker=[[UIImageView alloc]initWithFrame:CGRectMake(132, 77, 12, 10)];
    m_Tilt2Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];
    [self addSubview:m_Tilt2Tracker];
    
    m_Tilt3Tracker=[[UIImageView alloc]initWithFrame:CGRectMake(132, 120, 12, 10)];
    m_Tilt3Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];
    [self addSubview:m_Tilt3Tracker];
    
    m_Tilt4Tracker=[[UIImageView alloc]initWithFrame:CGRectMake(132, 163, 12, 10)];
    m_Tilt4Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];
    [self addSubview:m_Tilt4Tracker];
    
    m_RollTracker=[[UIImageView alloc]initWithFrame:CGRectMake(132, 207, 12, 10)];
    m_RollTracker.image=[UIImage imageNamed:@"GreenTracker.png"];
    [self addSubview:m_RollTracker];
    
  }
  return self;
}
-(void)reloadTracker
{
  [self connectToServer];
}
#pragma mark URLConnectionManager Methods

-(void)connectToServer
{
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
  
  m_ActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 200, 30, 30)];
  [m_ActivityIndicatorView startAnimating];
  m_ActivityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
  [self addSubview:m_ActivityIndicatorView];  
  
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
  NSString *pEntityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
  
	mURLConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetTrackerInfoforArray?sessionToken=%@&arrayID=%@",kserverAddress,pSessionToken,pEntityId]]] delegate:self];
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
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
  
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
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
  
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
  Tracker *pTracker=[[Tracker alloc]init];
  
  NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
  mResponseData=nil;
  //printf("\nJson String:%s\n",[responseString UTF8String]);
  
  NSDictionary *data=[responseString JSONValue];
  
  NSDictionary *userResult= [data objectForKey:@"GetTrackerInfoforArrayResult"]; 
  
  NSArray *rootResult = [userResult objectForKey:@"RootResults"];
  
  if([rootResult count])
  {
    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
    
    NSObject *error=[rootResultDict objectForKey:@"Err"];
    
    if([error isKindOfClass:[NSNull class]])
    {
      for(int i=0;i<[rootResult count];i++)
      {        
        NSDictionary *siteDictinary=[rootResult objectAtIndex:i];
        
        NSNumber *RollCommanded=[siteDictinary objectForKey:@"RollCommanded"];
        if(![RollCommanded isKindOfClass:[NSNull class]])
        {
          pTracker.mRollCommanded=[RollCommanded floatValue];
        }          
        
        NSNumber *RollPosition=[siteDictinary objectForKey:@"RollPosition"];
        if(![RollPosition isKindOfClass:[NSNull class]])
        {
          pTracker.mRollPosition=[RollPosition floatValue];
        }
        
        NSNumber *Tilt1Commanded=[siteDictinary objectForKey:@"Tilt1Commanded"];
        if(![Tilt1Commanded isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt1Commanded=[Tilt1Commanded floatValue];
        }
        
        NSNumber *Tilt1Position=[siteDictinary objectForKey:@"Tilt1Position"];
        if(![Tilt1Position isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt1Position=[Tilt1Position floatValue];
        }
        
        NSNumber *Tilt2Commanded=[siteDictinary objectForKey:@"Tilt2Commanded"];
        if(![Tilt2Commanded isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt2Commanded=[Tilt2Commanded floatValue];
        }
        
        NSNumber *Tilt2Position=[siteDictinary objectForKey:@"Tilt2Position"];
        if(![Tilt2Position isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt2Position=[Tilt2Position floatValue];
        }
        
        NSNumber *Tilt3Commanded=[siteDictinary objectForKey:@"Tilt3Commanded"];
        if(![Tilt3Commanded isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt3Commanded=[Tilt3Commanded floatValue];
        }
        
        NSNumber *Tilt3Position=[siteDictinary objectForKey:@"Tilt3Position"];
        if(![Tilt3Position isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt3Position=[Tilt3Position floatValue];
        }
        
        NSNumber *Tilt4Commanded=[siteDictinary objectForKey:@"Tilt4Commanded"];
        if(![Tilt4Commanded isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt4Commanded=[Tilt4Commanded floatValue];
        }
        
        NSNumber *Tilt4Position=[siteDictinary objectForKey:@"Tilt4Position"];
        if(![Tilt4Position isKindOfClass:[NSNull class]])
        {
          pTracker.mTilt4Position=[Tilt4Position floatValue];
        }        
      }
      
      float tracker1Diff=pTracker.mTilt1Position-pTracker.mTilt1Commanded+1.5;
      if(tracker1Diff<0.0 || tracker1Diff>3.0)
        m_Tilt1Tracker.image=[UIImage imageNamed:@"RedTracker.png"];
      else 
        m_Tilt1Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];
      float tracker1Offset=(tracker1Diff*210.0)/3.0+26.5;
      m_Tilt1Tracker.frame=CGRectMake(tracker1Offset, 27, 12, 10);
      
      if(tracker1Diff<0)
        m_Tilt1Tracker.frame=CGRectMake(22, 27, 12, 10);
      else if(tracker1Diff>3)
        m_Tilt1Tracker.frame=CGRectMake(240, 27, 12, 10);
      
      float tracker2Diff=pTracker.mTilt2Position-pTracker.mTilt2Commanded+1.5;
      if(tracker2Diff<0.0 || tracker2Diff>3.0)
        m_Tilt2Tracker.image=[UIImage imageNamed:@"RedTracker.png"];
      else 
        m_Tilt2Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];      
      float tracker2Offset=(tracker2Diff*210.0)/3.0+26.5;
      m_Tilt2Tracker.frame=CGRectMake(tracker2Offset, 77, 12, 10);
      
      if(tracker2Diff<0)
        m_Tilt2Tracker.frame=CGRectMake(22, 77, 12, 10);
      else if(tracker2Diff>3)
        m_Tilt2Tracker.frame=CGRectMake(240, 77, 12, 10);      
      
      float tracker3Diff=pTracker.mTilt3Position-pTracker.mTilt3Commanded+1.5;
      if(tracker3Diff<0.0 || tracker3Diff>3.0)
        m_Tilt3Tracker.image=[UIImage imageNamed:@"RedTracker.png"];
      else 
        m_Tilt3Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];            
      float tracker3Offset=(tracker3Diff*210.0)/3.0+26.5;
      m_Tilt3Tracker.frame=CGRectMake(tracker3Offset, 120, 12, 10);
      
      if(tracker3Diff<0)
        m_Tilt3Tracker.frame=CGRectMake(22, 120, 12, 10);
      else if(tracker3Diff>3)
        m_Tilt3Tracker.frame=CGRectMake(240, 120, 12, 10);      
      
      float tracker4Diff=pTracker.mTilt4Position-pTracker.mTilt4Commanded+1.5;
      if(tracker4Diff<0.0 || tracker4Diff>3.0)
        m_Tilt4Tracker.image=[UIImage imageNamed:@"RedTracker.png"];
      else 
        m_Tilt4Tracker.image=[UIImage imageNamed:@"GreenTracker.png"];            
      float tracker4Offset=(tracker4Diff*210.0)/3.0+26.5;
      m_Tilt4Tracker.frame=CGRectMake(tracker4Offset, 163, 12, 10);
      
      if(tracker4Diff<0)
        m_Tilt4Tracker.frame=CGRectMake(22, 163, 12, 10);
      else if(tracker4Diff>3)
        m_Tilt4Tracker.frame=CGRectMake(240, 163, 12, 10);      
      
      float rollDiff=pTracker.mRollPosition-pTracker.mRollCommanded+1.5;
      if(rollDiff<0.0 || rollDiff>3.0)
        m_RollTracker.image=[UIImage imageNamed:@"RedTracker.png"];
      else 
        m_RollTracker.image=[UIImage imageNamed:@"GreenTracker.png"];            
      float rollOffset=(rollDiff*210.0)/3.0+26.5;
      m_RollTracker.frame=CGRectMake(rollOffset, 207, 12, 10);
      
      if(rollDiff<0)
        m_RollTracker.frame=CGRectMake(22, 207, 12, 10);
      else if(rollDiff>3)
        m_RollTracker.frame=CGRectMake(240, 207, 12, 10);            
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
        if(m_delegate && [m_delegate respondsToSelector:@selector(fetchSessionTokenforTracker)])
          [m_delegate fetchSessionTokenforTracker];
      }            
    }
  }
}

- (void)dealloc
{
  m_delegate=nil;
  if(m_Tilt1Tracker){[m_Tilt1Tracker removeFromSuperview];}
  if(m_Tilt2Tracker){[m_Tilt2Tracker removeFromSuperview];}
  if(m_Tilt3Tracker){[m_Tilt3Tracker removeFromSuperview];}
  if(m_Tilt4Tracker){[m_Tilt4Tracker removeFromSuperview];}
  if(m_RollTracker){[m_RollTracker removeFromSuperview];}
  
  if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
  if(mResponseData)
	{
		mResponseData=nil;
	}  
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}  
  //printf("Dealloc in TrackerView\n");
}


@end