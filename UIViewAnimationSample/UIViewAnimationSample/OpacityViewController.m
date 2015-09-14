//
//  OpacityViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "OpacityViewController.h"

@interface OpacityViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueSquare;

@end

@implementation OpacityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blueSquare.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.blueSquare.alpha = 1.0;
    }];
}

@end
