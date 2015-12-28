//
//  ADPingDetailViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/28.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADPingDetailViewController.h"

@interface ADPingDetailViewController ()

@end

@implementation ADPingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.bounds.size.width - 70, 74, 60, 60);
    button.layer.cornerRadius = 30;
    button.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)buttonPressed:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
