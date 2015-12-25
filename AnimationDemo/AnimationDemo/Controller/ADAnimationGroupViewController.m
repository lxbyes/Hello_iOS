//
//  ADAnimationGroupViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADAnimationGroupViewController.h"

@interface ADAnimationGroupViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ADAnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view addSubview:backgroundImageView];
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"petal"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    // 创建动画组
    [self groupAnimation];
}

#pragma mark - basic rotation animation
- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    basicAnimation.toValue = @(M_PI_2 * 3);
    basicAnimation.autoreverses = YES;
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;
    
    [basicAnimation setValue:basicAnimation.toValue forKey:@"ADBasicAnimationProperty_ToValue"];
    
    return basicAnimation;
}

#pragma mark - keyframe translation animation
- (CAKeyframeAnimation *)translationAnimation {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 65, 400);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(65, 400)] forKey:@"ADKeyframeAnimationProperty_EndPosition"];
    
    return keyframeAnimation;
}

#pragma mark - create animation group
- (void)groupAnimation {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *basicAnimation = [self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation = [self translationAnimation];
    
    animationGroup.animations = @[basicAnimation, keyframeAnimation];
    
    animationGroup.delegate = self;
    animationGroup.duration = 10;
    animationGroup.beginTime = CACurrentMediaTime() + 2;
    
    [_layer addAnimation:animationGroup forKey:nil];
}

#pragma mark - delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAAnimationGroup *animationGroup = (CAAnimationGroup *)anim;
    
    CABasicAnimation *basicAnimation = (CABasicAnimation *)animationGroup.animations[0];
    CAKeyframeAnimation *keyframeAnimation = (CAKeyframeAnimation *)animationGroup.animations[1];
    
    CGFloat toValue = [[basicAnimation valueForKey:@"ADBasicAnimationProperty_ToValue"] floatValue];
    CGPoint endPoint = [[keyframeAnimation valueForKey:@"ADKeyframeAnimationProperty_EndPosition"] CGPointValue];
    
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    
    _layer.transform = CATransform3DMakeRotation(toValue, 0, 0, 1);
    _layer.position = endPoint;
    
    [CATransaction commit];
}
@end
