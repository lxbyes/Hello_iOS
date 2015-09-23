//
//  ClockFace.m
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "ClockFace.h"

@interface ClockFace ()

@property (strong, nonatomic) CAShapeLayer *hourHand;
@property (strong, nonatomic) CAShapeLayer *minuteHand;

@end

@implementation ClockFace

- (instancetype)init {
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        self.strokeColor = [UIColor purpleColor].CGColor;
        self.lineWidth = 4.0;
        
        self.hourHand = [CAShapeLayer layer];
        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 3, 70)].CGPath;
        self.hourHand.fillColor = [UIColor purpleColor].CGColor;
        self.hourHand.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [CAShapeLayer layer];
        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 2, 90)].CGPath;
        self.minuteHand.fillColor = [UIColor purpleColor].CGColor;
        self.minuteHand.position = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        [self addSublayer:self.minuteHand];
    }
    
    return self;
}

- (void)setTime:(NSDate *)time {
    _time = time;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:time];
    self.hourHand.affineTransform = CGAffineTransformMakeRotation(components.hour / 12.0 * 2 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(components.minute / 60.0 * 2 * M_PI);
}

@end
