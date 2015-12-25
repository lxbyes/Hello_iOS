//
//  ADParentViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADParentViewController.h"
#import "ADFirstViewController.h"
#import "ADSecondViewController.h"

@interface ADParentViewController ()

@property (nonatomic, strong) UIViewController *firstViewController;
@property (nonatomic, strong) UIViewController *secondViewController;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation ADParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _firstViewController = [[ADFirstViewController alloc] init];
    _secondViewController = [[ADSecondViewController alloc] init];
    
    [self addChildViewController:_firstViewController];
    [self.view addSubview:_firstViewController.view];
    _currentIndex = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *fromVC, *toVC;
    if (_currentIndex == 0) {
        fromVC = _firstViewController;
        toVC = _secondViewController;
        _currentIndex = 1;
    } else {
        fromVC = _secondViewController;
        toVC = _firstViewController;
        _currentIndex = 0;
    }
    
    [self addChildViewController:toVC];
    [fromVC willMoveToParentViewController:nil];
    [self.view addSubview:toVC.view];
    __weak id weadSelf = self;
    
    [self transitionFromViewController:fromVC toViewController:toVC duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    } completion:^(BOOL finished) {
        if (finished) {
            [fromVC.view removeFromSuperview];
            [fromVC removeFromParentViewController];
            [toVC didMoveToParentViewController:weadSelf];
        }
    }];
    
}

@end
