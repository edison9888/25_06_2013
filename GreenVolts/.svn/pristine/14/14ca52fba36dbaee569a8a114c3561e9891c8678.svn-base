//
//  InaverterView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "InverterView.h"
#import "Inverter.h"
#import "SBJson.h"
#import "LoginManager.h"
@interface InverterView(PVT)<LoginManagerDelegate>
-(void)connectToServer;
-(void)jsonParser;
-(void)fillVoltageValues;
@end


@implementation InverterView
@synthesize m_delegate;

- (id)initWithFrame:(CGRect)frame 
{    
  self = [super initWithFrame:frame];
  if (self) 
  {
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *pInverterImageView=[[UIImageView alloc]initWithFrame:CGRectMake(63, 6, 178, 233)];
    pInverterImageView.image=[UIImage imageNamed:@"Inverter.png"];
    [self addSubview:pInverterImageView];
    
    NSMutableArray *pInverterLabelArray=[[NSMutableArray alloc]initWithObjects:@"W1",@"W2",@"W3",@"W4",@"E1",@"E2",@"E3",@"E4",nil];
    
    int x=35,y=1;
    for(int i=0;i<8;i++)
    {
      UILabel *pTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 16, 20)];
      [pTitleLabel setBackgroundColor:[UIColor clearColor]];
      [pTitleLabel setTextColor:[UIColor colorWithRed:(87.1/100.0) green:(89.0/100.0) blue:(0.0/100.0) alpha:1.0]];
      [pTitleLabel setFont:[UIFont fontWithName:@"Arial" size:8]];
      [pTitleLabel setText:[pInverterLabelArray objectAtIndex:i]];
      if(i<4)
        [pTitleLabel setTextAlignment:UITextAlignmentRight];
      else 
        [pTitleLabel setTextAlignment:UITextAlignmentLeft];
      [self addSubview:pTitleLabel];
      
      switch (i)
      {
        case 0:
        {
          m_LabelW1=[[UILabel alloc]initWithFrame:CGRectMake(x-24, y+12, 40, 20)];
          [m_LabelW1 setBackgroundColor:[UIColor clearColor]];
          [m_LabelW1 setTextAlignment:UITextAlignmentRight];
          m_LabelW1.text=@"V";
          [m_LabelW1 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelW1 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelW1];
        }
          break;
        case 1:
        {
          m_LabelW2=[[UILabel alloc]initWithFrame:CGRectMake(x-24, y+12, 40, 20)];
          [m_LabelW2 setBackgroundColor:[UIColor clearColor]];
          m_LabelW2.text=@"V";
          [m_LabelW2 setTextAlignment:UITextAlignmentRight];
          [m_LabelW2 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelW2 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelW2];
        }
          break;
        case 2:
        {
          m_LabelW3=[[UILabel alloc]initWithFrame:CGRectMake(x-24, y+12, 40, 20)];
          [m_LabelW3 setBackgroundColor:[UIColor clearColor]];
          [m_LabelW3 setTextAlignment:UITextAlignmentRight];
          m_LabelW3.text=@"V";
          [m_LabelW3 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelW3 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelW3];
        }
          break;
        case 3:
        {
          m_LabelW4=[[UILabel alloc]initWithFrame:CGRectMake(x-24, y+12, 40, 20)];
          [m_LabelW4 setBackgroundColor:[UIColor clearColor]];
          m_LabelW4.text=@"V";
          [m_LabelW4 setTextAlignment:UITextAlignmentRight];
          [m_LabelW4 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelW4 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelW4];
        }
          break;
        case 4:
        {
          m_LabelE1=[[UILabel alloc]initWithFrame:CGRectMake(x, y+12, 40, 20)];
          [m_LabelE1 setBackgroundColor:[UIColor clearColor]];
          m_LabelE1.text=@"V";
          [m_LabelE1 setTextAlignment:UITextAlignmentLeft];
          [m_LabelE1 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelE1 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelE1];
        }
          break;
        case 5:
        {
          m_LabelE2=[[UILabel alloc]initWithFrame:CGRectMake(x, y+12, 40, 20)];
          [m_LabelE2 setBackgroundColor:[UIColor clearColor]];
          m_LabelE2.text=@"V";
          [m_LabelE2 setTextAlignment:UITextAlignmentLeft];
          [m_LabelE2 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelE2 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelE2];
        }
          break;
        case 6:
        {
          m_LabelE3=[[UILabel alloc]initWithFrame:CGRectMake(x, y+12, 40, 20)];
          [m_LabelE3 setBackgroundColor:[UIColor clearColor]];
          [m_LabelE3 setTextAlignment:UITextAlignmentLeft];
          m_LabelE3.text=@"V";
          [m_LabelE3 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelE3 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelE3];
        }
          break;
        case 7:
        {
          m_LabelE4=[[UILabel alloc]initWithFrame:CGRectMake(x, y+12, 40, 20)];
          [m_LabelE4 setBackgroundColor:[UIColor clearColor]];
          [m_LabelE4 setTextAlignment:UITextAlignmentLeft];
          m_LabelE4.text=@"V";
          [m_LabelE4 setTextColor:[UIColor colorWithRed:(39.6/100.0) green:(80.4/100.0) blue:0 alpha:1.0]];
          [m_LabelE4 setFont:[UIFont fontWithName:@"Arial" size:8]];
          [self addSubview:m_LabelE4];
        }
          break;
        default:
          break;
      }
      
      if(i==3)
      {
        x=x+218;
        y=1;
      }
      else 
      {
        y=y+62;
      }
    }
  }
  return self;
}
-(void)reloadInverter
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
  
  mURLConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetInverterDataforArray?sessionToken=%@&arrayID=%@",kserverAddress,pSessionToken,pEntityId]]] delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
  if(!mResponseData)
  {
    mResponseData=[NSMutableData data];
  }
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
  
  NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
  mResponseData=nil;
  //printf("\nJson String:%s\n",[responseString UTF8String]);
  
  NSDictionary *data=[responseString JSONValue];
  
  NSDictionary *userResult= [data objectForKey:@"GetInverterDataforArrayResult"]; 
  
  NSArray *rootResult = [userResult objectForKey:@"RootResults"];
  if([rootResult count])
  {
    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
    
    NSObject *error=[rootResultDict objectForKey:@"Err"];
    
    if([error isKindOfClass:[NSNull class]])
    {
      NSMutableArray *inverterArray=[[NSMutableArray alloc]init];
      for(int i=0;i<[rootResult count];i++)
      {
        Inverter *pInverter=[[Inverter alloc] init];
        
        NSDictionary *inverterDictionary=[rootResult objectAtIndex:i];
        
        NSNumber *pAC_Current=[inverterDictionary objectForKey:@"AC_Current"];
        if(![pAC_Current isKindOfClass:[NSNull class]])
        {
          pInverter.mAC_Current=[pAC_Current floatValue];
        }        
        
        NSNumber *pAC_Power=[inverterDictionary objectForKey:@"AC_Power"];
        if(![pAC_Power isKindOfClass:[NSNull class]])
        {
          pInverter.mAC_Power=[pAC_Power floatValue];
        }        
        
        NSNumber *pDC_Current=[inverterDictionary objectForKey:@"DC_Current"];
        if(![pDC_Current isKindOfClass:[NSNull class]])
        {
          pInverter.mDC_Current=[pDC_Current floatValue];
        }        
        
        NSNumber *pDC_Power=[inverterDictionary objectForKey:@"DC_Power"];
        if(![pDC_Power isKindOfClass:[NSNull class]])
        {
          pInverter.mDC_Power=[pDC_Power floatValue];
        }        
        
        NSNumber *pDC_Voltage=[inverterDictionary objectForKey:@"DC_Voltage"];
        if(![pDC_Voltage isKindOfClass:[NSNull class]])
        {
          pInverter.mDC_Voltage=[pDC_Voltage floatValue];
        }        
        
        NSNumber *pFrequency=[inverterDictionary objectForKey:@"Frequency"];
        if(![pFrequency isKindOfClass:[NSNull class]])
        {
          pInverter.mFrequency=[pFrequency floatValue];
        }        
        
        NSNumber *pGF_Current=[inverterDictionary objectForKey:@"GF_Current"];
        if(![pGF_Current isKindOfClass:[NSNull class]])
        {
          pInverter.mGF_Current=[pGF_Current floatValue];
        }        
        
        NSNumber *pGF_Impedance=[inverterDictionary objectForKey:@"GF_Impedance"];
        if(![pGF_Impedance isKindOfClass:[NSNull class]])
        {
          pInverter.mGF_Impedance=[pGF_Impedance floatValue];
        }        
        
        NSNumber *pGF_Voltage=[inverterDictionary objectForKey:@"GF_Voltage"];
        if(![pGF_Voltage isKindOfClass:[NSNull class]])
        {
          pInverter.mGF_Voltage=[pGF_Voltage floatValue];
        }        
        
        NSNumber *pPhase1=[inverterDictionary objectForKey:@"Phase1"];
        if(![pPhase1 isKindOfClass:[NSNull class]])
        {
          pInverter.mPhase1=[pPhase1 floatValue];
        }        
        
        NSNumber *pPhase2=[inverterDictionary objectForKey:@"Phase2"];
        if(![pPhase2 isKindOfClass:[NSNull class]])
        {
          pInverter.mPhase2=[pPhase2 floatValue];
        }        
        
        NSNumber *pPhase3=[inverterDictionary objectForKey:@"Phase3"];
        if(![pPhase3 isKindOfClass:[NSNull class]])
        {
          pInverter.mPhase3=[pPhase3 floatValue];
        }        
        
        NSString *pStringName=[inverterDictionary objectForKey:@"StringName"];
        if(![pStringName isKindOfClass:[NSNull class]])
        {
          pInverter.mStringName=pStringName;
        }        
        
        NSNumber *pStringNumber=[inverterDictionary objectForKey:@"StringNumber"];
        if(![pStringNumber isKindOfClass:[NSNull class]])
        {
          pInverter.mStringNumber=[pStringNumber floatValue];
        }       
        
        NSNumber *pVoltage_SubString1=[inverterDictionary objectForKey:@"Voltage_SubString1"];
        if(![pVoltage_SubString1 isKindOfClass:[NSNull class]])
        {
          pInverter.mVoltage_SubString1=[pVoltage_SubString1 floatValue];
        }       
        
        NSNumber *pVoltage_SubString2=[inverterDictionary objectForKey:@"Voltage_SubString2"];
        if(![pVoltage_SubString2 isKindOfClass:[NSNull class]])
        {
          pInverter.mVoltage_SubString2=[pVoltage_SubString2 floatValue];
        }       
        
        NSNumber *pVoltage_SubString3=[inverterDictionary objectForKey:@"Voltage_SubString3"];
        if(![pVoltage_SubString3 isKindOfClass:[NSNull class]])
        {
          pInverter.mVoltage_SubString3=[pVoltage_SubString3 floatValue];
        }       
        
        NSNumber *pVoltage_SubString4=[inverterDictionary objectForKey:@"Voltage_SubString4"];
        if(![pVoltage_SubString4 isKindOfClass:[NSNull class]])
        {
          pInverter.mVoltage_SubString4=[pVoltage_SubString4 floatValue];
        }       
        
        NSNumber *pFactor=[inverterDictionary objectForKey:@"pFactor"];
        if(![pFactor isKindOfClass:[NSNull class]])
        {
          pInverter.mpFactor=[pFactor floatValue];
        }   
        
        [inverterArray addObject:pInverter];
        pInverter=nil;
      }
      m_InverterArray=[NSArray arrayWithArray:inverterArray];
      [self fillVoltageValues];
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
        if(m_delegate && [m_delegate respondsToSelector:@selector(fetchSessionTokenforInverter)])
          [m_delegate fetchSessionTokenforInverter];
      }            
    }
  }
}

-(void)fillVoltageValues
{
  if(m_delegate && [m_delegate respondsToSelector:@selector(finishedDownloading:)])
    [m_delegate finishedDownloading:[NSArray arrayWithArray:m_InverterArray]];
  
  for(int i=0;i<[m_InverterArray count];i++)
  {
    Inverter *pInverter=[m_InverterArray objectAtIndex:i];
    if(pInverter.mStringNumber==1)
    {
      m_LabelE1.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString1];
      m_LabelE2.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString2];
      m_LabelE3.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString3];
      m_LabelE4.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString4];
    }
    else if(pInverter.mStringNumber==2)
    {
      m_LabelW1.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString1];
      m_LabelW2.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString2];
      m_LabelW3.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString3];
      m_LabelW4.text=[NSString stringWithFormat:@"%.02f V",pInverter.mVoltage_SubString4];
    }
  }
}
-(void)cleanUp
{
  if(m_InverterArray){m_InverterArray=nil;}
  
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
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}    

}
- (void)dealloc 
{
  if(m_InverterArray){m_InverterArray=nil;}
  
  //printf("Dealloc in InverterView\n");
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
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}    
  
}


@end
