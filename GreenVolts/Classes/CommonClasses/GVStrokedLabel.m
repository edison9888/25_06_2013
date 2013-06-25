//
//  GVStrokedLabel.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GVStrokedLabel.h"

@implementation GVStrokedLabel

@synthesize strokeColor;

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = self.strokeColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 1);
    self.shadowColor = self.strokeColor;
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;    
}

@end
