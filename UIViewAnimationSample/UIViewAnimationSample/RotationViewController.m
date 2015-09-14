//
//  RorationViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *wheelImage;

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self spin];
}

- (void)spin {
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.wheelImage.transform = CGAffineTransformRotate(self.wheelImage.transform, M_PI);
    } completion:^(BOOL finished) {
        [self spin];
    }];
}
@end
