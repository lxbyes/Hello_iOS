//
//  ADDrawLayerViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/22.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADDrawLayerViewController.h"

static CGFloat const kPhotoHeight = 160;

@implementation ADDrawLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawViews];
}

- (void)drawViews {
    CGPoint position = CGPointMake(160, 200);
    CGRect bounds = CGRectMake(0, 0, kPhotoHeight, kPhotoHeight);
    CGFloat cornerRadius = kPhotoHeight / 2;
    CGFloat borderWidth = 2;
    
    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = bounds;
    layerShadow.position = position;
    layerShadow.cornerRadius = cornerRadius;
    layerShadow.shadowColor = [UIColor grayColor].CGColor;
    layerShadow.shadowOffset = CGSizeMake(2, 1);
    layerShadow.shadowOpacity = 1;
    layerShadow.borderColor = [UIColor whiteColor].CGColor;
    layerShadow.borderWidth = borderWidth;
    [self.view.layer addSublayer:layerShadow];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = bounds;
    layer.position = position;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = cornerRadius;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds=YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //    layer.shadowColor=[UIColor grayColor].CGColor;
    //    layer.shadowOffset=CGSizeMake(2, 2);
    //    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = borderWidth;
    
    // x 轴旋转180
    //layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    // 二者等价
    //[layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
    
    // 设置图层代理
    //layer.delegate = self;
    //[layer setNeedsDisplay];

    // 设置图片
    [layer setContents:(id)[UIImage imageNamed:@"paizhao"].CGImage];
    
    [self.view.layer addSublayer:layer];
}

#pragma mark drawLayer
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    //CGContextScaleCTM(ctx, 1, -1);
    //CGContextTranslateCTM(ctx, 0, -kPhotoHeight);
    
    UIImage *image = [UIImage imageNamed:@"paizhao"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, kPhotoHeight, kPhotoHeight), image.CGImage);
    
    CGContextRestoreGState(ctx);
    
    // avoid crash when back to Main
    layer.delegate = nil;
}

@end
