//
//  UserData.m
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserData.h"
#import "Config.h"

@implementation UserData

@synthesize userData;

static UserData *_instance = nil;

+ (UserData *) getInstance {
	if(_instance == nil) {
		_instance = [[self allocWithZone:NULL] init];
	}
	return _instance;
}

+ (BOOL) userDataExists {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *plistDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [plistDirectory stringByAppendingPathComponent:@"userData.plist"];
	
	return [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
}

+ (BOOL) createNewUserData {
	BOOL success;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *plistDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [plistDirectory stringByAppendingPathComponent:@"userData.plist"];
	
	// if userData.plist is not created, create it.
	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
		NSArray *userObjects = [[NSArray alloc] initWithObjects:@"Joe", @"Smith", @"Smith Co", nil];
		NSArray *userKeys = [[NSArray alloc] initWithObjects:@"First Name", @"Last Name", @"Company", nil];
		NSDictionary *userSettings = [NSDictionary dictionaryWithObjects:userObjects forKeys:userKeys];
		success = [userSettings writeToFile:plistPath atomically:YES];
	}
	return success;
}

+ (BOOL) removeUserDataPlist {
	BOOL success;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *plistDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [plistDirectory stringByAppendingPathComponent:@"userData.plist"];
	success= [[NSFileManager defaultManager] removeItemAtPath:plistPath error:NULL];
	return success;
}

- (NSMutableDictionary *) getUserData {
	//NSLog(@"IN GET USER");
	[self readUserData];
	return userData;
}

- (void) readUserData {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *plistDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [plistDirectory stringByAppendingPathComponent:@"userData.plist"];
	
	//NSString *plistPath = [[NSBundle mainBundle] pathForResource:[[[Config getInstance] getConfig] objectForKey:@"userData"] ofType:@"plist"];
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];

	//NSLog(@"plistXML >>> %@", ([[[NSFileManager defaultManager] fileExistsAtPath:fullPath] isEqual:NULL])?@"YES":@"NO");
	userData = (NSMutableDictionary *)[NSPropertyListSerialization
											  propertyListFromData:plistXML
											  mutabilityOption:NSPropertyListMutableContainersAndLeaves
											  format:&format
											  errorDescription:&errorDesc];
    if (!userData) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
}

- (void) writeUserData:(NSMutableDictionary *) newUserData {
	if (newUserData != nil) {
		userData = newUserData;
	} else {
		[self readUserData];
	}

   	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *plistDirectory = [paths objectAtIndex:0];
	NSString *plistPath = [plistDirectory stringByAppendingPathComponent:@"userData.plist"];
	
	NSString *error;
	//NSString *plistPath = [[NSBundle mainBundle] pathForResource:[[[Config getInstance] getConfig] objectForKey:@"userData"] ofType:@"plist"];
  
	//NSLog(@"IN WRITE %@", plistPath);
	
	NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:userData
														format:NSPropertyListXMLFormat_v1_0
														errorDescription:&error];
    if(plistData) {
		//NSLog(@"IN WRITE %@", newUserData);
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"Error writing plist: %@", error);
        [error release];
    }
}

- (void) dealloc {
	
	[_instance release];
	//[userData release];
    [super dealloc];
}

@end
