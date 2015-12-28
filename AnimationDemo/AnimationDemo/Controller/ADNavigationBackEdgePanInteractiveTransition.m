//
//  ADEdgePanInteractiveTransition.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADNavigationBackEdgePanInteractiveTransition.h"

@interface ADNavigationBackEdgePanInteractiveTransition ()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation ADNavigationBackEdgePanInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.edges = UIRectEdgeLeft;
    [self.viewController.view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.viewController.view;
    CGPoint offset = [recognizer translationInView:view];
    CGFloat progress = offset.x / (view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(progress, 0.0));
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self.viewController.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (progress < 0.3) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
