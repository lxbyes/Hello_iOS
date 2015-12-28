//
//  ADSwipeInteractiveTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADSwipeInteractiveTransition.h"

@interface ADSwipeInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation ADSwipeInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController {
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view {
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.x / ([UIScreen mainScreen].bounds.size.width * 1.0);
            fraction = fminf(fmaxf(fraction * 1.2, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.4);
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
    
}

@end
