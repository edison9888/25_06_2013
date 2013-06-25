//
//  ServerURLManager.h
//  GreenVolts
//
//  Created by YML on 19/10/11.
//  Copyright (c) 2011 YML All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerURLManager : NSObject
+(NSString*)GetPortfolioSitesforUserWithSessionToken:(NSString*)SessionToken;
+(NSString*)GetSectionListforSiteWithSiteID:(NSString*)SiteID andSessionToken:(NSString*)SessionToken;
+(NSString*)GetArrayListforSectionWithSectionID:(NSString*)SectionID andSessionToken:(NSString*)SessionToken;
+(NSString*)GetStringListforArrayWithArrayID:(NSString*)ArrayID andSessionToken:(NSString*)SessionToken;
@end
