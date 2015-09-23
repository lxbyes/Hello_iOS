//
//  ClockFace2.m
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "ClockFace2.h"

@implementation ClockFace2

@dynamic time;

- (instancetype)init {
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, 200, 200);
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([@"time" isEqualToString:key]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void)display {
   
    float time = [self.presentationLayer time];
     NSLog(@"%f", time);
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 3);
    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 2, 2));
    
    CGFloat angle = time / 12.0 * 2.0 * M_PI;
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x + sin(angle) * 80, center.y - cos(angle) * 80);
    CGContextStrokePath(ctx);
    
    angle = (time - floor(time)) * 2.0 * M_PI;
    CGContextSetLineWidth(ctx, 2);
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x + sin(angle) * 90, center.y - cos(angle) * 90);
    CGContextStrokePath(ctx);
    
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
}

- (id<CAAction>)actionForKey:(NSString *)key {
    if ([key isEqualToString:@"time"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = @([[self presentationLayer] time]);
        return animation;
    }
    
    return [super actionForKey:key];
}

@end
