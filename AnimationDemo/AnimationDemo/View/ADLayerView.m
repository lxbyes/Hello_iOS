//
//  ADLayerView.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADLayerView.h"
#import "ADLayer.h"

@implementation ADLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ADLayer *layer = [[ADLayer alloc] init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(160, 284);
        layer.backgroundColor = [UIColor colorWithRed:0 green:146.0 / 255 blue:1.0 alpha:1].CGColor;
        
        layer.delegate = layer;
        [layer setNeedsDisplay];

        [self.layer addSublayer:layer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"View CGContextRef: %@", UIGraphicsGetCurrentContext());
    [super drawRect:rect];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"View layer CGContextRef: %@", ctx);
    [super drawLayer:layer inContext:ctx];
}

@end
