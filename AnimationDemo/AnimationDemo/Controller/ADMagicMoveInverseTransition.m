//
//  ADMagicMoveInverseTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADMagicMoveInverseTransition.h"
#import "ADCollectionViewController.h"
#import "ADDetailViewController.h"

@implementation ADMagicMoveInverseTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ADDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ADCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.view];
    fromVC.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    UICollectionViewCell *cell = [toVC.collectionView cellForItemAtIndexPath:toVC.collectionView.indexPathsForSelectedItems.lastObject];
    cell.contentView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0.0;
        snapShotView.frame = [containerView convertRect:CGRectOffset(cell.frame, 0, -toVC.collectionView.contentOffset.y) fromView:toVC.view];
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.contentView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
