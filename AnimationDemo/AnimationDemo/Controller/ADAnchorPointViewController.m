//
//  ADAnchorPointViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/22.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADAnchorPointViewController.h"

static CGFloat const kWidth = 50;

@implementation ADAnchorPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawMyLayer];
}

#pragma mark draw
- (void)drawMyLayer {
    CGSize size = self.view.bounds.size;
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor colorWithRed:0 green:146 / 255 blue:1.0 alpha:1.0].CGColor;
    layer.position = CGPointMake(size.width / 2, size.height / 2);
    layer.bounds = CGRectMake(0, 0, kWidth, kWidth);
    layer.cornerRadius = kWidth / 2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
    //layer.masksToBounds = YES;
    
    [self.view.layer addSublayer:layer];
}

#pragma mark click
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CALayer *layer = [self.view.layer.sublayers lastObject];
    CGFloat width = layer.bounds.size.width;
    if (width == kWidth) {
        width = kWidth * 4;
    } else {
        width = kWidth;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width / 2;
}

@end
