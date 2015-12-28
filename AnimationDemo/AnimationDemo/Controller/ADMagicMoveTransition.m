//
//  ADMagicMoveTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/25.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADMagicMoveTransition.h"
#import "ADCollectionViewController.h"
#import "ADDetailViewController.h"

@implementation ADMagicMoveTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ADCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ADDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UICollectionViewCell *cell = [fromVC.collectionView cellForItemAtIndexPath:fromVC.collectionView.indexPathsForSelectedItems.lastObject];
    UIView *snapShotView = [cell.contentView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:cell.contentView.frame fromView:cell.contentView.superview];
    cell.contentView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];
    } completion:^(BOOL finished) {
        cell.contentView.hidden = NO;
        toVC.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    /*
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];

    } completion:^(BOOL finished) {
        cell.contentView.hidden = NO;
        toVC.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];*/
}
@end
