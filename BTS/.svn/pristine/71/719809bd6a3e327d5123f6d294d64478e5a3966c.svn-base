//
//  PostData.h
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PostData : NSObject {
    NSMutableData *response;
    int round;
}

@property (nonatomic, retain) NSMutableData *serverResponse;

- (void) sendDataToServerForRound:(int) roundNum;
+ (PostData *) getInstance;

@end
