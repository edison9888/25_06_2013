//
//  Config.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize config;

static Config *_instance = nil;

+ (Config *) getInstance {
	if(_instance == nil) {
		_instance = [[self allocWithZone:NULL] init];
	}
	return _instance;
}


+ (int) getTotalRounds {
	return [[_instance.config objectForKey:@"rounds"] count];
}

- (NSDictionary *) getConfig {
	return [config retain];
}
- (void) loadConfigFile {
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
	if (config == nil) {
		config = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	}
}

- (NSArray *) getKPIsForRound:(int) roundNum {
	return [[[config objectForKey:@"rounds"] objectAtIndex:roundNum] objectForKey:@"KPIs"];
}

- (NSArray *) getMaxKPIsForRound:(int) roundNum {
	return [[[config objectForKey:@"rounds"] objectAtIndex:roundNum] objectForKey:@"maxKPIs"];
}

- (NSString *) getNameForRound:(int) roundNum {
	return [[[config objectForKey:@"rounds"] objectAtIndex:roundNum] objectForKey:@"title"];
}

- (NSString *) getEmailText {
	return [config objectForKey:@"emailText"];
}

- (NSString *) getVoicemailText {
	return [config objectForKey:@"voicemailText"];
}

- (NSString *) getScrollDownInstructionalText {
    return [config objectForKey:@"instructionalText"];
}

- (void) dealloc {
	
	[_instance release];
    [super dealloc];
}

@end
