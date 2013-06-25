//
//  Config.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Config : NSObject {
@private
	NSDictionary *config;
}

@property (nonatomic, retain) NSDictionary *config;

+ (Config *) getInstance;
+ (int) getTotalRounds;

- (void) loadConfigFile;
- (NSDictionary *) getConfig;
- (NSArray *) getKPIsForRound:(int) roundNum;
- (NSArray *) getMaxKPIsForRound:(int) roundNum;
- (NSString *) getNameForRound:(int) roundNum;
- (NSString *) getEmailText;
- (NSString *) getVoicemailText;
- (NSString *) getScrollDownInstructionalText;

@end
