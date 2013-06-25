//
//  WindView.m
//  GreenVolts
//
//  Created by YML on 8/27/11.
//  Copyright 2011 YML. All rights reserved.
//

#import "WindView.h"
#import "DrawWindGraphView.h"
#import "EntityDetails.h"
#import "SBJson.h"
#import "LoginManager.h"
@interface WindView(PVT)<LoginManagerDelegate>
-(void)fillXAxis;
-(void)fillLeftYAxis;
-(void)drawLevelLines;
-(void)showWindDirection;
-(void)connectToServer;
-(void)jsonParser;
-(void)getValuesArray;
-(void)drawMarkers;
-(CGFloat)yOffsetForValue:(float)value;
@end


@implementation WindView
@synthesize m_deleagte;

-(id)initWithFrame:(CGRect)frame
{
  self=[super initWithFrame:frame];
  if(self)
  {
    MaximumYValue=0;
    UILabel *leftgraphTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(-18, 83, 40, 12)];
    leftgraphTitleLabel.text=@"Wind (m/s)";
    leftgraphTitleLabel.textColor=[UIColor whiteColor];
    leftgraphTitleLabel.textAlignment=UITextAlignmentRight;
    leftgraphTitleLabel.backgroundColor=[UIColor clearColor];
    leftgraphTitleLabel.transform=CGAffineTransformMakeRotation((M_PI*3)/2);
    [leftgraphTitleLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
    [self addSubview:leftgraphTitleLabel];
  }
  return self;
}

-(void)drawGraphFromValues:(NSArray*)values
{
  MaximumYValue=0;
    
  NSMutableArray *windSpeedArray=[[NSMutableArray alloc]init];
  NSMutableArray *windDirectionArray=[[NSMutableArray alloc]init];
  for(int i=0;i<[values count];i++)
  {
    EntityDetails *pEntityDetails=[values objectAtIndex:i];
    if(pEntityDetails.m_WindSpeed!=nil)
      [windSpeedArray addObject:pEntityDetails.m_WindSpeed];
    if((i%12) == 0)
    {
      if(pEntityDetails.m_WindDirection!=nil)
        [windDirectionArray addObject:pEntityDetails.m_WindDirection];
    }
  }
  if(m_YValueArray)
    m_YValueArray=nil;
  m_YValueArray=[NSArray arrayWithArray:windSpeedArray];
  if(m_WindDirectionArray)
    m_WindDirectionArray=nil;
  m_WindDirectionArray=[NSArray arrayWithArray:windDirectionArray];
  [self connectToServer];
}
#pragma mark URLConnectionManager Methods

-(void)connectToServer
{
  m_ActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(131, 85, 30, 30)];
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
  NSString *pEntityType=[[NSUserDefaults standardUserDefaults]objectForKey:@"ENTITY_TYPE"];
  NSString *pEntityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
  
  mURLConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetWeatherConfigforEntity?sessionToken=%@&entityScope=%@&entityID=%@",kserverAddress,pSessionToken,pEntityType,pEntityId]]] delegate:self];
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
  if([m_LevelArray count])
  {
    m_LevelArray=nil;
  }
  
  NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
  
  if(mResponseData)
	{
		mResponseData=nil;
	}  
  
  //printf("\nJson String:%s\n",[responseString UTF8String]);
  NSMutableArray *levelArray=[[NSMutableArray alloc]init];
  
  NSDictionary *data=[responseString JSONValue];
  
  NSDictionary *userResult= [data objectForKey:@"GetWeatherConfigforEntityResult"]; 
  
  NSArray *rootResult = [userResult objectForKey:@"RootResults"];
  
  if([rootResult count])
  {
    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
    
    NSObject *error=[rootResultDict objectForKey:@"Err"];
    
    if([error isKindOfClass:[NSNull class]])
    {
      for(int i=0;i<[rootResult count];i++)
      {
        NSString *pValue;
        
        NSDictionary *siteDictinary=[rootResult objectAtIndex:i];
        
        NSString *pMAWL1=[siteDictinary objectForKey:@"ParameterName"];
        if(![pMAWL1 isKindOfClass:[NSNull class]])
        {
          if([pMAWL1 isEqualToString:@"MAWL1"])
          {
            pValue=[siteDictinary objectForKey:@"ParameterValue"];
            [levelArray addObject:pValue];
          }
        }          
        
        NSString *pUAWL=[siteDictinary objectForKey:@"ParameterName"];
        if(![pUAWL isKindOfClass:[NSNull class]])
        {
          if([pMAWL1 isEqualToString:@"UAWL"])
          {
            pValue=[siteDictinary objectForKey:@"ParameterValue"];
            [levelArray addObject:pValue];
          }
        }          
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
        if(m_deleagte && [m_deleagte respondsToSelector:@selector(fetchSessionTokenforWind)])
          [m_deleagte fetchSessionTokenforWind];
      }            
    }
  }
  m_LevelArray=[NSArray arrayWithArray:levelArray];
  
  if([m_YValueArray count]!=0)
  {
    for(int i=0;i<[m_LevelArray count];i++)
    {
      NSString *cur=[m_LevelArray objectAtIndex:i];  
      int curVal=[cur intValue];
      if(curVal>MaximumYValue)
        MaximumYValue=curVal;
    }
    float avgWindSpeed=0;
    float totalSpeed=0;
    for (NSString *windSpeed in m_YValueArray)
    {
      totalSpeed+=[windSpeed floatValue];
    }
    
    avgWindSpeed=totalSpeed/[m_YValueArray count];
    MaximumYValue=MAX(MaximumYValue, avgWindSpeed);
    
    float maximum=1.2*MaximumYValue;
    int roundedBy=5;
    int dividedNoRemainder=(int)(maximum/roundedBy);
    double yMax=dividedNoRemainder*roundedBy;
    MaximumYValue=MAX(yMax, MaximumYValue+5);
    [self getValuesArray];
  }
  else
  {
    for(int i=0;i<[m_LevelArray count];i++)
    {
      NSString *cur=[m_LevelArray objectAtIndex:i];  
      int curVal=[cur intValue];
      if(curVal>MaximumYValue)
        MaximumYValue=curVal;
    }
    float avgWindSpeed=0;
    MaximumYValue=MAX(MaximumYValue, avgWindSpeed);
    
    float maximum=1.2*MaximumYValue;
    int roundedBy=5;
    int dividedNoRemainder=(int)(maximum/roundedBy);
    double yMax=dividedNoRemainder*roundedBy;
    MaximumYValue=MAX(yMax, MaximumYValue+5);
    [self getValuesArray];
  }
}
/*
 Max = Max of the (Avg Wind Speed, Threshold to Enter Emergency Stow, Threshold to Exit Emergency Stow).
 
 // Add 20% and then round to the nearest 5;
 int roundedBy = 5;
 int dividedNoRemainder = (int)(max * 1.2 / roundedBy);
 
 double yMax = dividedNoRemainder * roundedBy;
 
 // if after all that, we are not at least 5 higher than the max, then force it higher
 return Math.Max(yMax, max + 5);
 
 */
-(void)getValuesArray
{
  MaximumHeight=160;  
  for (UIView *view in self.subviews) 
  {
    if(view.tag==888)
    {
      [view removeFromSuperview];
    }
  }
  [self fillXAxis];
  [self fillLeftYAxis];
  if([m_YValueArray count]>0)
  {
    DrawWindGraphView *pDrawWindGraphView=[[DrawWindGraphView alloc]initWithFrame:CGRectMake(16,15,275,160) array:m_YValueArray maximumValue:MaximumYValue];
    pDrawWindGraphView.tag=888;
    [self addSubview:pDrawWindGraphView];  
  }
  [self drawLevelLines];
  [self showWindDirection];  
  [self drawMarkers];
}

-(void)showWindDirection
{
  for(int i=0;i<[m_WindDirectionArray count];i++)
  {
    NSString *degreeVal=[m_WindDirectionArray objectAtIndex:i];
    float degree=[degreeVal floatValue];
    UIImageView *pDirectionImageView=[[UIImageView alloc]initWithFrame:CGRectMake(12+(i*11.5), 179, 7, 9)];
    [pDirectionImageView setImage:[UIImage imageNamed:@"WindArrow.png"]];
    
    if(degree>=337.5 &&degree<22.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(180*(M_PI/180))]; 
    else if(degree>=22.5 && degree<67.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(225*(M_PI/180))]; 
    else if(degree>=67.5 && degree<112.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(270*(M_PI/180))]; 
    else if(degree>=112.5 && degree<157.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(315*(M_PI/180))]; 
    else if(degree>=157.5 && degree<202.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(360*(M_PI/180))]; 
    else if(degree>=202.5 && degree<247.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(45*(M_PI/180))]; 
    else if(degree>=247.5 && degree<292.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(90*(M_PI/180))]; 
    else if(degree>=292.5 && degree<337.5)
      [pDirectionImageView setTransform:CGAffineTransformMakeRotation(135*(M_PI/180))]; 
    pDirectionImageView.tag=888;
    [self addSubview:pDirectionImageView];          
  }
}

-(void)drawLevelLines
{
  if([m_LevelArray count]>1)
  {
    float firstVal=0;
    float secondVal=0;
    
    
    firstVal=[[m_LevelArray objectAtIndex:0] floatValue];
    secondVal=[[m_LevelArray objectAtIndex:1] floatValue];
    
    CGFloat yOffsetForFirstValue=[self yOffsetForValue:firstVal];
    CGFloat yOffsetForSecondValue=[self yOffsetForValue:secondVal];
    
    UIImageView *firstImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15.5,yOffsetForFirstValue-5,276.5,2)];
    firstImageView.image=[UIImage imageNamed:@"RedLine.png"];
    firstImageView.tag=888;
    [self addSubview:firstImageView];
    
    UIImageView *secondImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15.5,yOffsetForSecondValue-5,276.5,2)];
    secondImageView.image=[UIImage imageNamed:@"WhiteLine.png"];
    secondImageView.tag=888;
    [self addSubview:secondImageView];
  }
}

-(void)fillXAxis
{
  NSArray *m_XValueArray=[NSArray arrayWithObjects:@"12 AM",@"1 AM",@"2 AM",@"3 AM",@"4 AM",@"5 AM",@"6 AM",@"7 AM",@"8 AM",@"9 AM",@"10 AM",@"11 AM",@"12 PM",
                 @"1 PM",@"2 PM",@"3 PM",@"4 PM",@"5 PM",@"6 PM",@"7 PM",@"8 PM",@"9 PM",@"10 PM",@"11 PM",@"12 AM",nil];
  for(int i=0;i<[m_XValueArray count];i++)
  {
    UILabel *pXAxisLabel=[[UILabel alloc]initWithFrame:CGRectMake(6+(i*11.5), 196, 20, 10)];
    NSString *text=[m_XValueArray objectAtIndex:i];
    pXAxisLabel.text=text;
    pXAxisLabel.textColor=[UIColor whiteColor];
    pXAxisLabel.backgroundColor=[UIColor clearColor];
    pXAxisLabel.textAlignment=UITextAlignmentLeft;
    pXAxisLabel.transform=CGAffineTransformMakeRotation(M_PI/2.5);
    [pXAxisLabel setFont:[UIFont fontWithName:@"Arial" size:6]];
    pXAxisLabel.tag=888;
    [self addSubview:pXAxisLabel];
    
    UIImageView *pImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15+(i*11.5),14.5, 1.5, 161)];
    pImageView.image=[UIImage imageNamed:@"VerticalLine.png"];
    pImageView.tag=888;
    [self addSubview:pImageView];
  }
}

-(void)fillLeftYAxis
{
  int noOfScales=0;
  int multiplier=0;
  if((int)MaximumYValue%10==0)
    noOfScales=MaximumYValue/10,multiplier=10;
  else
    noOfScales=MaximumYValue/5,multiplier=5;
  
  for (int i=0;i<=noOfScales;i++)
  {
    CGRect frame=CGRectMake(-2,[self yOffsetForValue:i*multiplier]-8,15,8);
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=[NSString stringWithFormat:@"%d",i*multiplier];
    label.textAlignment=UITextAlignmentRight;
    [label setFont:[UIFont fontWithName:@"Arial" size:6]];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.adjustsFontSizeToFitWidth=YES;
    label.tag=888;
    [self addSubview:label];
    
    UIImageView *pImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15,[self yOffsetForValue:i*multiplier]-5.5, 277, 2)];
    pImageView.image=[UIImage imageNamed:@"HorizontalLine.png"];
    pImageView.tag=888;
    [self addSubview:pImageView];
  }
}

- (void)dealloc 
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
  if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
  //printf("Dealloc in WindView\n");
  
}

-(CGFloat)yOffsetForValue:(float)value
{
  CGFloat yOffset=0;
  //Graph MaximumHeight = 160
  //Graph origin = 180
  
  float yOffsetForSingleValue=MaximumHeight/MaximumYValue;
  yOffset=yOffsetForSingleValue*value;
  yOffset=180-yOffset;
  return yOffset;
}

-(void)drawMarkers
{
  UIView *markerView=[[UIView alloc]initWithFrame:CGRectMake(20,21,145,36)];
  markerView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
  markerView.tag=888;
  [self addSubview:markerView];
  
  UILabel *pAverageWindSpeedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,135, 12)];
  pAverageWindSpeedLabel.text=@"Average Wind Speed (m/s)";
  pAverageWindSpeedLabel.textColor=[UIColor whiteColor];
  pAverageWindSpeedLabel.backgroundColor=[UIColor clearColor];
  [pAverageWindSpeedLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
  [markerView addSubview:pAverageWindSpeedLabel];        
  
  UIView *pAverageWindSpeedImageView=[[UIView alloc]initWithFrame:CGRectMake(2,2,6,6)];
  pAverageWindSpeedImageView.backgroundColor=[UIColor colorWithRed:(0.0) green:(62.4/100.0) blue:(2.4/100.0) alpha:1.0];
  [markerView addSubview:pAverageWindSpeedImageView];
  
  UILabel *pEnterThreshholdLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,12,135, 12)];
  pEnterThreshholdLabel.text=@"Threshold to Enter Wind Stow (m/s)";
  pEnterThreshholdLabel.textColor=[UIColor whiteColor];
  pEnterThreshholdLabel.backgroundColor=[UIColor clearColor];
  [pEnterThreshholdLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
  [markerView addSubview:pEnterThreshholdLabel];     
  
  UIView *pEnterThreshholdImageView=[[UIView alloc]initWithFrame:CGRectMake(2,14,6, 6)];
  pEnterThreshholdImageView.backgroundColor=[UIColor redColor];
  [markerView addSubview:pEnterThreshholdImageView];
  
  UILabel *pExitThreshholdLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,24,135,12)];
  pExitThreshholdLabel.text=@"Threshold to Exit Wind Stow (m/s)";
  pExitThreshholdLabel.textColor=[UIColor whiteColor];
  pExitThreshholdLabel.backgroundColor=[UIColor clearColor];
  [pExitThreshholdLabel setFont:[UIFont fontWithName:@"Arial" size:7]];
  [markerView addSubview:pExitThreshholdLabel];    
  
  UIView *pExitThreshholdImageView=[[UIView alloc]initWithFrame:CGRectMake(2,26,6,6)];
  pExitThreshholdImageView.backgroundColor=[UIColor colorWithRed:(45.1/100.0) green:(45.1/100.0) blue:(45.1/100.0) alpha:1.0];
  [markerView addSubview:pExitThreshholdImageView];
  
  UIView *pDirectionImageBG=[[UIView alloc]initWithFrame:CGRectMake(236, 4, 55, 55)];
  pDirectionImageBG.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
  pDirectionImageBG.tag=888;
  [self addSubview:pDirectionImageBG];
  
  UIImageView *pDirectionImageView=[[UIImageView alloc]initWithFrame:CGRectMake(236, 4, 55, 55)];
  [pDirectionImageView setImage:[UIImage imageNamed:@"Direction.png"]];
  pDirectionImageView.tag=888;
  [self addSubview:pDirectionImageView];
}
@end
