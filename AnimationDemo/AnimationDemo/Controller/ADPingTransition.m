//
//  ADPingTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADPingTransition.h"
#import "ADPingViewController.h"

@interface ADPingTransition ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation ADPingTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    ADPingViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIButton *button = fromVC.button;
    
    [containerView addSubview:toVC.view];
    
    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    CGPoint finalPoint = CGPointMake(button.center.x, button.center.y - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    //创建一个关于 path 的 CABasicAnimation 动画来从 circleMaskPathInitial.CGPath 到 circleMaskPathFinal.CGPath 。同时指定它的 delegate 来在完成动画时做一些清除工作
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)maskStartBP.CGPath;
    maskLayerAnimation.toValue = (__bridge id)maskFinalBP.CGPath;
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
