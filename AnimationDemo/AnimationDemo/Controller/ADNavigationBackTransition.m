//
//  ADNavigationBackTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADNavigationBackTransition.h"

@implementation ADNavigationBackTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
      
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    toVC.view.frame = CGRectOffset([transitionContext finalFrameForViewController:toVC], -toVC.view.bounds.size.width / 3, 0);
    toVC.view.alpha = 0.8;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.frame = [containerView convertRect:CGRectOffset(fromVC.view.frame, fromVC.view.bounds.size.width, 0) fromView:fromVC.view];
        toVC.view.frame = CGRectOffset(toVC.view.frame, toVC.view.bounds.size.width / 3, 0);
        toVC.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
