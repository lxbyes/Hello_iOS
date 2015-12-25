//
//  ADBounceDismissAnimation.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADBounceDismissAnimation.h"

@implementation ADBounceDismissAnimation

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, screenBounds.size.width, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = finalFrame;
        fromVC.view.alpha = 0.1;
        fromVC.view.backgroundColor = [UIColor yellowColor];
        fromVC.view.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
