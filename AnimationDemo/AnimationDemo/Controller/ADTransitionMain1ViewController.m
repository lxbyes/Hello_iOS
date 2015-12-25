//
//  ADTransitionMain1ViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADTransitionMain1ViewController.h"
#import "ADTransitionModal1ViewController.h"
#import "ADBouncePresentAnimation.h"
#import "ADSwipeInteractiveTransition.h"
#import "ADBounceDismissAnimation.h"

@interface ADTransitionMain1ViewController () <ModelViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) ADBouncePresentAnimation *bouncePresentAnimation;
@property (nonatomic, strong) ADBounceDismissAnimation *dismissAnimation;
@property (nonatomic, strong) ADSwipeInteractiveTransition *interactiveTransition;

@end

@implementation ADTransitionMain1ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _bouncePresentAnimation = [[ADBouncePresentAnimation alloc] init];
        _dismissAnimation = [[ADBounceDismissAnimation alloc] init];
        _interactiveTransition = [[ADSwipeInteractiveTransition alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80, 210, 160, 40);
    [button setTitle:@"Show modal" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(id)sender {
    ADTransitionModal1ViewController *viewController = [[ADTransitionModal1ViewController alloc] init];
    viewController.delegate = self;
    viewController.transitioningDelegate = self;
    [self.interactiveTransition wireToViewController:viewController];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - ModelViewControllerDelegate
- (void)modalViewControllerDidDismiss:(ADTransitionModal1ViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.bouncePresentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}
@end
