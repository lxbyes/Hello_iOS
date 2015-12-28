//
//  ADPingViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADPingViewController.h"
#import "ADPingDetailViewController.h"
#import "ADPingTransition.h"

@interface ADPingViewController () <UINavigationControllerDelegate>

@end

@implementation ADPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame = CGRectMake(self.view.bounds.size.width - 70, 74, 60, 60);
    _button.layer.cornerRadius = 30;
    _button.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)buttonPressed:(UIButton *)button {
    ADPingDetailViewController *viewController = [[ADPingDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ADPingDetailViewController class]]) {
        ADPingTransition *transition = [[ADPingTransition alloc] init];
        return transition;
    }
    return nil;
}
@end
