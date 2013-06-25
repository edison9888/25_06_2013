//
//  GreenvoltsOCUnit.m
//  GreenvoltsOCUnit
//
//  Created by Jos Vandevelde on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GreenvoltsOCUnit.h"


@implementation GreenvoltsOCUnit

- (void) testSample {  
    NSMutableArray *array = [NSMutableArray array];
	[array addObject:[FMCommandEvent command:@"Return" className:@"UITextField" monkeyID:@"Password" delay:@"500.25" timeout:@"10000" args:[NSArray arrayWithObjects:@"v3d@nth", nil]]];
	[array addObject:[FMCommandEvent command:@"VScroll" className:@"SiteListTileView" monkeyID:@"#2" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"0", @"50", nil]]];
    [array addObject:[FMCommandEvent command:@"Touch" className:@"SiteListTileView" monkeyID:@"#2" delay:@"500.1" timeout:@"10000" args:[NSArray arrayWithObjects:@"137", @"50", nil]]];
    
    [array addObject:[FMCommandEvent command:@"ProgramaticSlide" className:@"DrawGraphView" monkeyID:@"#0" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"left", nil]]];
    
//  [array addObject:[FMCommandEvent command:@"Move" className:@"DrawGraphView" monkeyID:@"#0" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"280",@"85",@"260",@"84", nil]]];
//  [array addObject:[FMCommandEvent command:@"Scroll" className:@"DrawGraphView" monkeyID:@"#0" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"280",@"0",nil]]];   
    [array addObject:[FMCommandEvent command:@"Pause" className:@"" monkeyID:@"" delay:@"" timeout:@"" args:[NSArray arrayWithObjects:@"2000", nil]]];
    [array addObject:[FMCommandEvent command:@"Touch" className:@"UIButton" monkeyID:@"#0" delay:@"500.4" timeout:@"10000" args:[NSArray arrayWithObjects:@"50", @"30", nil]]];
//	[array addObject:[FMCommandEvent command:@"Move" className:@"DrawGraphView" monkeyID:@"#0" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"280", @"85", @"180", @"85", nil]]];
    [array addObject:[FMCommandEvent command:@"Touch" className:@"UIButton" monkeyID:@"#0" delay:@"500.0" timeout:@"10000" args:[NSArray arrayWithObjects:@"44", @"10", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"UIButton" monkeyID:@"#2" delay:@"500.19" timeout:@"10000" args:[NSArray arrayWithObjects:@"44", @"10", nil]]];
	[array addObject:[FMCommandEvent command:@"VScroll" className:@"UITableView" monkeyID:@"#0" delay:@"500.26" timeout:@"10000" args:[NSArray arrayWithObjects:@"0", nil]]];
	[array addObject:[FMCommandEvent command:@"VScroll" className:@"UITableView" monkeyID:@"#0" delay:@"500.08" timeout:@"10000" args:[NSArray arrayWithObjects:@"0", nil]]];
	[array addObject:[FMCommandEvent command:@"VScroll" className:@"UITableView" monkeyID:@"#0" delay:@"500.34" timeout:@"10000" args:[NSArray arrayWithObjects:@"0", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"SiteListTileView" monkeyID:@"#1" delay:@"500.943" timeout:@"10000" args:[NSArray arrayWithObjects:@"165", @"62", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"UIButton" monkeyID:@"#0" delay:@"500.14" timeout:@"10000" args:[NSArray arrayWithObjects:@"37", @"56", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"UIButton" monkeyID:@"#2" delay:@"500.205" timeout:@"10000" args:[NSArray arrayWithObjects:@"44", @"20", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"UITabBarButton" monkeyID:@"Control" delay:@"500.91" timeout:@"10000" args:[NSArray arrayWithObjects:@"59", @"18", nil]]];
	[array addObject:[FMCommandEvent command:@"Touch" className:@"UITabBarButton" monkeyID:@"Alerts" delay:@"500.253" timeout:@"10000" args:[NSArray arrayWithObjects:@"27", @"18", nil]]];
    
	NSString *lastResult = [FoneMonkeyAPI playCommands:array];
	STAssertNil(lastResult, lastResult);  	
}

@end