//
//  ADLayer.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADLayer.h"

@implementation ADLayer

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"CGContextRef: %@", ctx);
    CGContextSetRGBFillColor(ctx, 135.0 / 255, 232.0 / 255, 84.0 / 255, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0 / 255, 232.0 / 255, 84.0 / 255, 1);
    
    CGContextMoveToPoint(ctx, 94.5, 33.5);
    //// Star Drawing
    CGContextAddLineToPoint(ctx,104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
