//
//  BulletNode.h
//  TextShooter
//
//  Created by 赖显波 on 9/6/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BulletNode : SKNode

+ (instancetype)bulletFrom:(CGPoint)start toward:(CGPoint)destination;
- (void)applyRecurringForce;

@end
