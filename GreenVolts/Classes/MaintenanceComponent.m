//
//  MaintenanceComponent.m
//  GreenVolts
//
//  Created by Shinu Mohan on 05/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaintenanceComponent.h"

@implementation MaintenanceComponent
@synthesize displayOrder,err,errId,name,iD,isReplacedRequired,requiredValidation;
@synthesize isSelected;

-(id)init
{
    if(self  = [super init])
    {
        displayOrder =nil;
        err=nil;
        errId=nil;
        iD=nil;
        isReplacedRequired=NO;
        requiredValidation=NO;
        name=nil;
        
        
    }
    return self;
}


@end