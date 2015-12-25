//
//  ADTransitionModel1ViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADTransitionModal1ViewController.h"

@implementation ADTransitionModal1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80, 210, 160, 40);
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidDismiss:)]) {
        [self.delegate modalViewControllerDidDismiss:self];
    }
}

@end
