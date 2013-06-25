//
//  ServerURLManager.m
//  GreenVolts
//
//  Created by YML on 19/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import "ServerURLManager.h"

@implementation ServerURLManager
+(NSString*)GetPortfolioSitesforUserWithSessionToken:(NSString*)SessionToken
{
  NSString *URL=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetPortfolioSitesforUser?sessionToken=%@",kserverAddress,SessionToken];
  return URL;
}

+(NSString*)GetSectionListforSiteWithSiteID:(NSString*)SiteID andSessionToken:(NSString*)SessionToken
{
  NSString *URL=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetSectionListforSite?sessionToken=%@&siteID=%@",kserverAddress,SessionToken,SiteID];
  return URL;
}

+(NSString*)GetArrayListforSectionWithSectionID:(NSString*)SectionID andSessionToken:(NSString*)SessionToken
{
  NSString *URL=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetArrayListforSection?sessionToken=%@&sectionID=%@",kserverAddress,SessionToken,SectionID];
  return URL;
}

+(NSString*)GetStringListforArrayWithArrayID:(NSString*)ArrayID andSessionToken:(NSString*)SessionToken
{
  NSString *URL=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetStringListforArray?sessionToken=%@&arrayID=%@",kserverAddress,SessionToken,ArrayID];
  return URL;
}
@end
