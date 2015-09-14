//
//  ScaleViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ScaleViewController.h"

@interface ScaleViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueSquare;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blueSquare.transform = CGAffineTransformMakeScale(1.5, 0.5);
    }];
}

@end
