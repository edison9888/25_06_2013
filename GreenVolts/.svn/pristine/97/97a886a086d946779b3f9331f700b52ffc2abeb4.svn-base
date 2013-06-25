//
//  DataPrefetcher.m
//  GreenVolts
//
//  Created by YML on 19/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "DataPrefetcher.h"
#import "Site.h"
#import "Section.h"
#import "Array.h"
#import "String.h"
#import "ServerURLManager.h"
#import "SBJson.h"
#import "GreenVoltsAppDelegate.h"
@interface DataPrefetcher()
-(void)fetchSessionToken;
@end
@implementation DataPrefetcher
@synthesize delegate;
-(id)init
{
  self=[super init];
  if(self)
  {
    delegate=nil;
    mConnection=nil;
    buffer=nil;
    mAuthenticationConnection=nil;
  }
  return self;
}
-(void)dealloc
{
  delegate=nil;
  mAuthenticationConnection=nil;
  if(mConnection)
  {
    [mConnection cancel];
    mConnection=nil;
  }
  if(buffer)
  {
    buffer=nil;
  }
  if(currentObject)
  {
    currentObject=nil;
  }
  
}
-(void)CancelConnection
{
  if(mConnection)
  {
    [mConnection cancel];
    mConnection=nil;
  }
  if(buffer)
  {
    buffer=nil;
  }
  delegate=nil;
  currentObject=nil;
}
-(void)GetClassToBeJumpedFrom:(NSObject*)CurrentObject
{
  if(CurrentObject==nil)
    currentObject=nil;
  else
  {
    currentObject=CurrentObject;
  }
  if(mConnection)
  {
    [mConnection cancel];
    mConnection=nil;
  }
  if([CurrentObject isKindOfClass:[Site class]])
  {
    //Fetch Section List for Site
    Site *currentSite=(Site*)CurrentObject;
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSURL *url=[NSURL URLWithString:[ServerURLManager GetSectionListforSiteWithSiteID:currentSite.m_SiteId andSessionToken:pSessionToken]];
    //printf("\nDataPrefetcher fetch URL:\n%s\n",[[url description]UTF8String]);
    mConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [mConnection start];
  }
  else if([CurrentObject isKindOfClass:[Section class]])
  {
    //Fetch Array List for Section
    Section *currentSection=(Section*)CurrentObject;
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSURL *url=[NSURL URLWithString:[ServerURLManager GetArrayListforSectionWithSectionID:currentSection.m_SectionId andSessionToken:pSessionToken]];
    //printf("\nDataPrefetcher fetch URL:\n%s\n",[[url description]UTF8String]);
    mConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [mConnection start];
  }
  else if([CurrentObject isKindOfClass:[Array class]])
  {
    //Fetch String List for Array
    Array *currentArray=(Array*)CurrentObject;
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSURL *url=[NSURL URLWithString:[ServerURLManager GetStringListforArrayWithArrayID:currentArray.m_ArrayId andSessionToken:pSessionToken]];
    //printf("\nDataPrefetcher fetch URL:\n%s\n",[[url description]UTF8String]);
    mConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [mConnection start];
  }
  else
  {
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSURL *url=[NSURL URLWithString:[ServerURLManager GetPortfolioSitesforUserWithSessionToken:pSessionToken]];
    //printf("\nDataPrefetcher fetch URL:\n%s\n",[[url description]UTF8String]);
    mConnection=[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [mConnection start];
  }
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  if(buffer)
  {
    buffer=nil;
  }
  buffer=[NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   
  [buffer appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  if(delegate)
  {
    [delegate dataPrefetcherFoundInternetError:self];
  }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSString *responseString=[[NSString alloc]initWithData:buffer encoding:NSUTF8StringEncoding];
  buffer=nil;
  //printf("\nDataPrefetcher response:\n%s\n",[responseString UTF8String]);
  if([currentObject isKindOfClass:[Site class]])
  {
    Site *m_Site=(Site*)currentObject;
    NSDictionary *data=[responseString JSONValue];
    NSDictionary *userResult= [data objectForKey:@"GetSectionListforSiteResult"]; 
    
    NSArray *rootResult = [userResult objectForKey:@"RootResults"];
    
    if([rootResult count])
    {
      NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
      
      NSObject *error=[rootResultDict objectForKey:@"Err"];
      
      if([error isKindOfClass:[NSNull class]])
      {      
        m_Site.totalCount=[[userResult objectForKey:@"TotalCount"] intValue];
        NSMutableArray *sectionArray=[NSMutableArray array];
        for(int i=0;i<[rootResult count];i++)
        {
          NSDictionary *siteDictinary=[rootResult objectAtIndex:i];
          Section *pSection=[[Section alloc]init];
          
          NSObject *pAlarmCount=[siteDictinary objectForKey:@"AlarmCount"];
          if(![pAlarmCount isKindOfClass:[NSNull class]])
            pSection.AlarmCount=[[siteDictinary objectForKey:@"AlarmCount"] intValue];
          
          NSObject *pArrayCount=[siteDictinary objectForKey:@"ArrayCount"];
          if(![pArrayCount isKindOfClass:[NSNull class]])
            pSection.ArrayCount=[[siteDictinary objectForKey:@"ArrayCount"] intValue];
          
          NSObject *pCameraID=[siteDictinary objectForKey:@"CameraID"];
          if(![pCameraID isKindOfClass:[NSNull class]])
            pSection.CameraID=[[siteDictinary objectForKey:@"CameraID"] intValue];        
          
          NSObject *pSiteId=[siteDictinary objectForKey:@"ID"];
          if(![pSiteId isKindOfClass:[NSNull class]])
            pSection.m_SectionId=[siteDictinary objectForKey:@"ID"];  
          
          NSObject *pCurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          if(![pCurrentDNI isKindOfClass:[NSNull class]])
            pSection.m_CurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          
          NSObject *pCurrentPower=[siteDictinary objectForKey:@"CurrentPower"];
            if(![pCurrentPower isKindOfClass:[NSNull class]]) 
            pSection.m_CurrentPower=[siteDictinary objectForKey:@"CurrentPower"];
            
          NSObject *pLocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          if(![pLocalDateTime isKindOfClass:[NSNull class]])
            pSection.m_LocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          
          NSObject *pLocation=[siteDictinary objectForKey:@"Location"];
          if(![pLocation isKindOfClass:[NSNull class]])
            pSection.m_Location=[siteDictinary objectForKey:@"Location"];
          
          NSObject *pName=[siteDictinary objectForKey:@"Name"];
          if(![pName isKindOfClass:[NSNull class]])
            pSection.m_Name=[siteDictinary objectForKey:@"Name"];
          
          NSObject *pTemperature=[siteDictinary objectForKey:@"Temperature"];
          if(![pTemperature isKindOfClass:[NSNull class]])
            pSection.m_Temperature=[[siteDictinary objectForKey:@"Temperature"] stringValue];
          
          NSString *pWindDirection=(NSString *)[siteDictinary objectForKey:@"WindDirection"];
          if(![pWindDirection isEqualToString:@""])
            pSection.m_WindDirection=[siteDictinary objectForKey:@"WindDirection"];
          
          NSObject *pWindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          if(![pWindSpeed isKindOfClass:[NSNull class]])
            pSection.m_WindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          
          NSObject *pTodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          if(![pTodayEnergy isKindOfClass:[NSNull class]])
            pSection.m_TodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          
          NSObject *pUTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          if(![pUTCDateTime isKindOfClass:[NSNull class]])
            pSection.m_UTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          
          NSObject *pUTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          if(![pUTCOffset isKindOfClass:[NSNull class]])
            pSection.m_UTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          
          NSObject *pWeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          if(![pWeatherStatus isKindOfClass:[NSNull class]])
            pSection.m_WeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          
          NSObject *pWeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];
          if(![pWeatherIcon isKindOfClass:[NSNull class]])
            pSection.m_WeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];        
          
          NSObject *pYTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          if(![pYTDEnergy isKindOfClass:[NSNull class]])
            pSection.m_YTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          
          if(pSection.ArrayCount>0)
            [sectionArray addObject:pSection];
          
          pSection=nil;
        }
        m_Site.m_SectionArray=[NSArray arrayWithArray:sectionArray];
        sectionArray=nil;
        if([m_Site.m_SectionArray count]==1)
        {
          Section *pSection=[m_Site.m_SectionArray objectAtIndex:0];
          currentObject=nil;
          [self GetClassToBeJumpedFrom:pSection];
        }
        else
        {
          if(delegate)
          {
            [delegate dataPrefetcher:self decidedToJumpToObject:currentObject];
          }
        }
      }
      else
      {
        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
        if([errorId intValue]==10002)
        {
          if(delegate)
          {
            [delegate dataPrefetcherFoundMissingToken:self];
          }
        }
        if([errorId intValue]==10003)
        {
          [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ERROR"];
          
          [self fetchSessionToken];
        }            
      }
    }
  }
  else if([currentObject isKindOfClass:[Section class]])
  {
    
    Section *m_Section=(Section*)currentObject;
    
    NSDictionary *data=[responseString JSONValue];
    
    NSDictionary *userResult= [data objectForKey:@"GetArrayListforSectionResult"]; 
    
    NSArray *rootResult = [userResult objectForKey:@"RootResults"];
    
    if([rootResult count])
    {
      NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
      
      NSObject *error=[rootResultDict objectForKey:@"Err"];
      
      if([error isKindOfClass:[NSNull class]])
      {
        m_Section.totalCount=[[userResult objectForKey:@"TotalCount"] intValue];
        NSMutableArray *arrayArray=[NSMutableArray array];
        for(int i=0;i<[rootResult count];i++)
        {
          NSDictionary *siteDictinary=[rootResult objectAtIndex:i];
          Array *pArray=[[Array alloc]init];
          
          NSObject *pAlarmCount=[siteDictinary objectForKey:@"AlarmCount"];
          if(![pAlarmCount isKindOfClass:[NSNull class]])
            pArray.AlarmCount=[[siteDictinary objectForKey:@"AlarmCount"] intValue];
          
          NSObject *pArrayCount=[siteDictinary objectForKey:@"ArrayCount"];
          if(![pArrayCount isKindOfClass:[NSNull class]])
            pArray.ArrayCount=[[siteDictinary objectForKey:@"ArrayCount"] intValue];
          
          NSObject *pCameraID=[siteDictinary objectForKey:@"CameraID"];
          if(![pCameraID isKindOfClass:[NSNull class]])
            pArray.CameraID=[[siteDictinary objectForKey:@"CameraID"] intValue];                
          
          NSObject *pSiteId=[siteDictinary objectForKey:@"ID"];
          if(![pSiteId isKindOfClass:[NSNull class]])
            pArray.m_ArrayId=[siteDictinary objectForKey:@"ID"];      
          
          NSObject *pCurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          if(![pCurrentDNI isKindOfClass:[NSNull class]])
            pArray.m_CurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          
          NSObject *pCurrentPower=[siteDictinary objectForKey:@"CurrentPower"];
            if(![pCurrentPower isKindOfClass:[NSNull class]]) 
            pArray.m_CurrentPower=[siteDictinary objectForKey:@"CurrentPower"];


          NSObject *pLocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          if(![pLocalDateTime isKindOfClass:[NSNull class]])
            pArray.m_LocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          
          NSObject *pLocation=[siteDictinary objectForKey:@"Location"];
          if(![pLocation isKindOfClass:[NSNull class]])
            pArray.m_Location=[siteDictinary objectForKey:@"Location"];
          
          NSObject *pName=[siteDictinary objectForKey:@"Name"];
          if(![pName isKindOfClass:[NSNull class]])
            pArray.m_Name=[siteDictinary objectForKey:@"Name"];
          
          NSObject *pTemperature=[siteDictinary objectForKey:@"Temperature"];
          if(![pTemperature isKindOfClass:[NSNull class]])
            pArray.m_Temperature=[[siteDictinary objectForKey:@"Temperature"] stringValue];
          
          NSString *pWindDirection=(NSString *)[siteDictinary objectForKey:@"WindDirection"];
          if(![pWindDirection isEqualToString:@""])
            pArray.m_WindDirection=[siteDictinary objectForKey:@"WindDirection"];
          
          NSObject *pWindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          if(![pWindSpeed isKindOfClass:[NSNull class]])
            pArray.m_WindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          
          NSObject *pTodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          if(![pTodayEnergy isKindOfClass:[NSNull class]])
            pArray.m_TodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          
          NSObject *pUTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          if(![pUTCDateTime isKindOfClass:[NSNull class]])
            pArray.m_UTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          
          NSObject *pUTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          if(![pUTCOffset isKindOfClass:[NSNull class]])
            pArray.m_UTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          
          NSObject *pWeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          if(![pWeatherStatus isKindOfClass:[NSNull class]])
            pArray.m_WeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          
          NSObject *pWeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];
          if(![pWeatherIcon isKindOfClass:[NSNull class]])
            pArray.m_WeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];                
          
          NSObject *pYTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          if(![pYTDEnergy isKindOfClass:[NSNull class]])
            pArray.m_YTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          
          [arrayArray addObject:pArray];
          
          pArray=nil;
        }
        m_Section.m_arrayArray=[NSArray arrayWithArray:arrayArray];
        arrayArray=nil;
        if([m_Section.m_arrayArray count]==1)
        {
          Array *pArray=[m_Section.m_arrayArray objectAtIndex:0];
          currentObject=nil;
          [self GetClassToBeJumpedFrom:pArray];
        }
        else 
        {
          if(delegate)
          {
            [delegate dataPrefetcher:self decidedToJumpToObject:currentObject];
          }
        }
      }
      else 
      {
        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
        if([errorId intValue]==10002)
        {
          if(delegate)
          {
            [delegate dataPrefetcherFoundMissingToken:self];
          }
        }
        if([errorId intValue]==10003)
        {
          [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ERROR"];
          
          [self fetchSessionToken];
        }    
      }
    }
  }
  else if([currentObject isKindOfClass:[Array class]])
  {
    Array *m_Array=(Array*)currentObject;
    
    NSDictionary *data=[responseString JSONValue];
    
    NSDictionary *userResult= [data objectForKey:@"GetStringListforArrayResult"]; 
    
    NSArray *rootResult = [userResult objectForKey:@"RootResults"];
    
    if([rootResult count])
    {
      NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
      
      NSObject *error=[rootResultDict objectForKey:@"Err"];
      
      if([error isKindOfClass:[NSNull class]])
      {
        m_Array.totalCount=[[userResult objectForKey:@"TotalCount"] intValue];
        NSMutableArray *stringArray=[NSMutableArray array];
        for(int i=0;i<[rootResult count];i++)
        {
          NSDictionary *siteDictinary=[rootResult objectAtIndex:i];
          String *pString=[[String alloc]init];
          
          NSObject *pAlarmCount=[siteDictinary objectForKey:@"AlarmCount"];
          if(![pAlarmCount isKindOfClass:[NSNull class]])
            pString.AlarmCount=[[siteDictinary objectForKey:@"AlarmCount"] intValue];
          
          NSObject *pArrayCount=[siteDictinary objectForKey:@"ArrayCount"];
          if(![pArrayCount isKindOfClass:[NSNull class]])
            pString.ArrayCount=[[siteDictinary objectForKey:@"ArrayCount"] intValue];
          
          NSObject *pSiteId=[siteDictinary objectForKey:@"ID"];
          if(![pSiteId isKindOfClass:[NSNull class]])
            pString.m_StringId=[siteDictinary objectForKey:@"ID"];      
          
          NSObject *pCurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          if(![pCurrentDNI isKindOfClass:[NSNull class]])
            pString.m_CurrentDNI=[siteDictinary objectForKey:@"CurrentDNI"];
          
          NSObject *pCurrentPower=[siteDictinary objectForKey:@"CurrentPower"];
            if(![pCurrentPower isKindOfClass:[NSNull class]]) 
            pString.m_CurrentPower=[siteDictinary objectForKey:@"CurrentPower"];

          NSObject *pLocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          if(![pLocalDateTime isKindOfClass:[NSNull class]])
            pString.m_LocalDateTime=[siteDictinary objectForKey:@"LocalDateTime"];
          
          NSObject *pLocation=[siteDictinary objectForKey:@"Location"];
          if(![pLocation isKindOfClass:[NSNull class]])
            pString.m_Location=[siteDictinary objectForKey:@"Location"];
          
          NSObject *pName=[siteDictinary objectForKey:@"Name"];
          if(![pName isKindOfClass:[NSNull class]])
            pString.m_Name=[siteDictinary objectForKey:@"Name"];
          
          NSObject *pTemperature=[siteDictinary objectForKey:@"Temperature"];
          if(![pTemperature isKindOfClass:[NSNull class]])
            pString.m_Temperature=[[siteDictinary objectForKey:@"Temperature"] stringValue];
          
          NSString *pWindDirection=(NSString *)[siteDictinary objectForKey:@"WindDirection"];
          if(![pWindDirection isEqualToString:@""])
            pString.m_WindDirection=[siteDictinary objectForKey:@"WindDirection"];
          
          NSObject *pWindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          if(![pWindSpeed isKindOfClass:[NSNull class]])
            pString.m_WindSpeed=[siteDictinary objectForKey:@"WindSpeed"];
          
          NSObject *pTodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          if(![pTodayEnergy isKindOfClass:[NSNull class]])
            pString.m_TodayEnergy=[siteDictinary objectForKey:@"TodayEnergy"];
          
          NSObject *pUTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          if(![pUTCDateTime isKindOfClass:[NSNull class]])
            pString.m_UTCDateTime=[siteDictinary objectForKey:@"UTCDateTime"];
          
          NSObject *pUTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          if(![pUTCOffset isKindOfClass:[NSNull class]])
            pString.m_UTCOffset=[siteDictinary objectForKey:@"UTCOffset"];
          
          NSObject *pWeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          if(![pWeatherStatus isKindOfClass:[NSNull class]])
            pString.m_WeatherStatus=[siteDictinary objectForKey:@"WeatherStatus"];
          
          NSObject *pWeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];
          if(![pWeatherIcon isKindOfClass:[NSNull class]])
            pString.m_WeatherIcon=[siteDictinary objectForKey:@"WeatherIcon"];                        
          
          NSObject *pYTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          if(![pYTDEnergy isKindOfClass:[NSNull class]])
            pString.m_YTDEnergy=[siteDictinary objectForKey:@"YTDEnergy"];
          
          [stringArray addObject:pString];
          
          pString=nil;
        }
        m_Array.m_StringArray=[NSArray arrayWithArray:stringArray];
        stringArray=nil;

          if(delegate)
          {
            [delegate dataPrefetcher:self decidedToJumpToObject:currentObject];
          }

      }
      else 
      {
        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
        if([errorId intValue]==10002)
        {
          if(delegate)
          {
            [delegate dataPrefetcherFoundMissingToken:self];
          }
        }
        if([errorId intValue]==10003)
        {
          [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ERROR"];
          
          [self fetchSessionToken];
        }      
      }
    }

  }
}

-(void)fetchSessionToken
{
  if(!mAuthenticationConnection)
  {
    mAuthenticationConnection=[[NewConnection alloc]init];
  }
  mAuthenticationConnection.m_delegate=self;
  [mAuthenticationConnection connectToServer]; 
}
-(void)ConnectionFailed
{
  UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Make sure your device has an active network connection and try again" delegate:nil
                                      
                                      
                                      
                                      
                                      cancelButtonTitle:@"OK" otherButtonTitles:NULL];
  [pAlert show];
  pAlert=nil;
  mAuthenticationConnection=nil;
}
-(void)InvalidUserNameError:(int)errorIndex
{
  if(errorIndex==0)
  {
    UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Cannot connect to backend systems" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
    [pAlert show];
    pAlert=nil;              
  }
  else if(errorIndex==1)
  {    
    if(delegate)
    {
      [delegate dataPrefetcherFoundMissingToken:self];
    }
  }
  mAuthenticationConnection=nil;
}
-(void)Success
{
  [self GetClassToBeJumpedFrom:currentObject];
  mAuthenticationConnection=nil;
}
@end


