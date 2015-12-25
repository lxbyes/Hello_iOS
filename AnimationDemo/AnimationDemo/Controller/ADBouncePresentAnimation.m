//
//  ADBouncePresentAnimation.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADBouncePresentAnimation.h"

@implementation ADBouncePresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"%@", [[toVC class] description]);
    // 2. Set init frame for toVC
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    if ([toVC isKindOfClass:[UINavigationController class]]) {
        toVC.view.frame = CGRectOffset(finalFrame, -screenBounds.size.width, 0);
    } else {
        toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
    }
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        // 5. Tell context that we completed.
        [transitionContext completeTransition:YES];
    }];
}

@end
