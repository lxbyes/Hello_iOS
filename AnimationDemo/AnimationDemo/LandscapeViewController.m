//
//  LandscapeViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 9/11/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "LandscapeViewController.h"

@interface LandscapeViewController ()

@end

@implementation LandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight);
}

@end
