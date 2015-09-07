//
//  SKNode+Extra.m
//  TextShooter
//
//  Created by 赖显波 on 9/6/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "SKNode+Extra.h"
#import "Geometry.h"

@implementation SKNode (Extra)

- (void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact {
    self.physicsBody.affectedByGravity = YES;
    CGVector force = VectorMultiply(attacker.physicsBody.velocity, contact.collisionImpulse);
    CGPoint myContact = [self.scene convertPoint:contact.contactPoint toNode:self];
    
    [self.physicsBody applyForce:force atPoint:myContact];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MissileExplosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    explosion.numParticlesToEmit = 20;
    explosion.position = contact.contactPoint;
    [self.scene addChild:explosion];
    
    [self runAction:[SKAction playSoundFileNamed:@"enemyHit.wav" waitForCompletion:NO]];
}

- (void)friendlyBumpFrom:(SKNode *)node {
    self.physicsBody.affectedByGravity = YES;
}

@end
