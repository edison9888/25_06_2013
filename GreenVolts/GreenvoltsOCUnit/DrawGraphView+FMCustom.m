//
//  PagingView+FMCustom.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrawGraphView+FMCustom.h"

@implementation DrawGraphView (FMCustom)

- (void) playbackMonkeyEvent:(FMCommandEvent *)event { 
    if ([event.command isEqualToString:@"ProgramaticSlide"]) {
        [self programaticSlide:[event.args objectAtIndex:0]];
    }
    else {
        [super playbackMonkeyEvent:event];
    }
}

- (void) programaticSlide:(NSString *)dir {
    NSLog(@"%@", [[UIApplication sharedApplication] delegate]);
    NSLog(@"%@", (PagingView *)[(ArrayViewController *)([[[(UITabBarController *)([(GreenVoltsAppDelegate *)([[UIApplication sharedApplication] delegate]) RootViewController]) viewControllers] objectAtIndex:0] visibleViewController]) view]);
    NSLog(@"%@", [[[UIApplication sharedApplication] delegate] window].rootViewController);
    NSLog(@"%@", [[UIApplication sharedApplication].delegate window].rootViewController.view);
    
    UIView* view = ([[(GreenVoltsAppDelegate *)([UIApplication sharedApplication].delegate) window].rootViewController view]); 
    
    PagingView *paging = (PagingView*)view;
    [[paging delegate] pagingView:paging willDisplayPage:paging.currentPage+([dir isEqualToString:@"left"] ? 1 : -1)];	
    //[view ];
}

@end