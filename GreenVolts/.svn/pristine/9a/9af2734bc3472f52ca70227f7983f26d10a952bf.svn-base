//
//  GVRect.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GVRect.h"

@implementation GVRect
@synthesize visible;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        visible = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(c, 128/255., 128/255., 128/255., visible ? 1. : 0.0); 
    CGContextSetRGBFillColor(c, 1.,1.,1.,0.);
    CGContextStrokeRectWithWidth(c, rect, 1.);
}
@end
