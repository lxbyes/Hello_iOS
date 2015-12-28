//
//  ADDetailViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/25.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADDetailViewController.h"
#import "ADMagicMoveInverseTransition.h"
#import "ADCollectionViewController.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface ADDetailViewController () <UINavigationControllerDelegate>

//@property (nonatomic, strong) ADNavigationBackEdgePanInteractiveTransition *detailFinishDrivenTransition;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation ADDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewsInit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewsInit {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(64, 84, kScreenWidth - 128, kScreenWidth)];
    //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @(self.index % 5)]];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 8, kScreenWidth, kScreenWidth / 4 * 3, kScreenWidth)];
    _label.numberOfLines = 0;
    _label.text = @"QWERTYUIOOPSDFGHJKLXCVBNMqwertyuiopsdfghjklzxcvbnm1234567890-=;',./@#$%^&*()_+`~QWERTYUIOOPSDFGHJKLXCVBNMqwertyuiopsdfghjklzxcvbnm1234567890-=;',./@#$%^&*()_+`~QWERTYUIOOPSDFGHJKLXCVBNMqwertyuiopsdfghjklzxcvbnm1234567890-=;',./@#$%^&*()_+`~";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imageView];
    [self.view addSubview:_label];
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer {
    UIView *view = self.view;
    CGPoint offset = [recognizer translationInView:view];
    CGFloat progress = offset.x / (view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(progress * 1.3, 0.0));
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.percentDrivenTransition updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (progress < 0.3) {
                [self.percentDrivenTransition cancelInteractiveTransition];
            } else {
                [self.percentDrivenTransition finishInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ADCollectionViewController class]]) {
        ADMagicMoveInverseTransition *inverseTransition = [[ADMagicMoveInverseTransition alloc] init];
        return inverseTransition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[ADMagicMoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}
@end
