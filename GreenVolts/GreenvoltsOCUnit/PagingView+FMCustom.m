//
//  PagingView+FMCustom.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PagingView+FMCustom.h"

@implementation PagingView (FMCustom)

- (void) playbackMonkeyEvent:(FMCommandEvent *)event { 
    if ([event.command isEqualToString:@"Function"]) {
        [event.args objectAtIndex:0];
    }
    else {
        [super playbackMonkeyEvent:event];
    }
}

@end
