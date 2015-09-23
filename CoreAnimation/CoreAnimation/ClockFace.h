//
//  ClockFace.h
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ClockFace : CAShapeLayer

@property (strong, nonatomic) NSDate *time;

@end
