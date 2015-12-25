//
//  ADViewLayerViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADViewLayerViewController.h"
#import "ADLayerView.h"

@implementation ADViewLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ADLayerView *view = [[ADLayerView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor colorWithRed:249.0 / 255 green:249.0 / 255 blue:249.0 / 255 alpha:1];
    
    [self.view addSubview:view];
}
@end
