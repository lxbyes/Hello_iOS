//
//  BallView.m
//  Ball
//
//  Created by 赖显波 on 9/7/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "BallView.h"

@interface BallView ()

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGPoint currentPoint;
@property (assign, nonatomic) CGPoint previousPoint;
@property (assign, nonatomic) CGFloat ballXVelocity;
@property (assign, nonatomic) CGFloat ballYVelocity;

@end

@implementation BallView

- (void)commonInit {
    self.image = [UIImage imageNamed:@"feiji.png"];
    self.currentPoint = CGPointMake((self.bounds.size.width / 2) + (self.image.size.width / 2), (self.bounds.size.height / 2) + (self.image.size.height / 2));
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.image drawAtPoint:self.currentPoint];
}

#pragma mark -

- (void)setCurrentPoint:(CGPoint)currentPoint {
    self.previousPoint = self.currentPoint;
    _currentPoint = currentPoint;
    
    if (self.currentPoint.x < 0) {
        _currentPoint.x = 0;
        self.ballXVelocity = 0;
    }
    
    if (self.currentPoint.y < 0) {
        _currentPoint.y = 0;
        self.ballYVelocity = 0;
    }
    
    if (self.currentPoint.x > self.bounds.size.width - self.image.size.width) {
        _currentPoint.x = self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = 0;
    }
    
    if (self.currentPoint.y > self.bounds.size.height - self.image.size.height) {
        _currentPoint.y = self.bounds.size.height - self.image.size.height;
        self.ballYVelocity = 0;
    }
    
    CGRect currentRect = CGRectMake(self.currentPoint.x, self.currentPoint.y, self.currentPoint.x + self.image.size.width, self.image.size.height);
    CGRect previousRect = CGRectMake(self.previousPoint.x, self.previousPoint.y, self.previousPoint.x + self.image.size.width, self.previousPoint.y + self.image.size.height);
    
    [self setNeedsDisplayInRect:CGRectUnion(currentRect, previousRect)];
}

- (void)update {
    static NSDate *lastUpdateTime = nil;
    
    if (lastUpdateTime != nil) {
        NSTimeInterval secondSinceLastDraw = [[NSDate date] timeIntervalSinceDate:lastUpdateTime];
        
        self.ballXVelocity = self.ballXVelocity + (self.acceleration.x * secondSinceLastDraw);
        self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondSinceLastDraw);
        
        CGFloat xAccel = secondSinceLastDraw * self.ballXVelocity * 500;
        CGFloat yAccel = secondSinceLastDraw * self.ballYVelocity * 500;
        
        self.currentPoint = CGPointMake(self.currentPoint.x + xAccel, self.currentPoint.y + yAccel);
    }
    
    lastUpdateTime = [[NSDate alloc] init];
}

@end
