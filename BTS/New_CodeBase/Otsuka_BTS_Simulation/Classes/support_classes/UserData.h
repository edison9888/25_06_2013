//
//  UserData.h
//  Otsuka_Sales_Simulation
//
//  Created by administrator on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserData : NSObject {
@private
	NSMutableDictionary *userData;
}

@property (nonatomic, retain) NSMutableDictionary *userData;

+ (UserData *) getInstance;
+ (BOOL) userDataExists;
+ (BOOL) createNewUserData;
+ (BOOL) removeUserDataPlist;

- (NSMutableDictionary *) getUserData;
- (void) readUserData;
- (void) writeUserData:(NSMutableDictionary *) newUserData;

@end
