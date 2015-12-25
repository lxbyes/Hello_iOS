//
//  ADCoreAnimation2ViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADCoreAnimation2ViewController.h"

@interface ADCoreAnimation2ViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ADCoreAnimation2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"petal"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    [self transitionCurveAnimation];
}

// 关键帧动画
- (void)transitionAnimation {
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    //2.设置关键帧,这里有四个关键帧
    NSValue *value1 = [NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(65, 600)];
    keyframeAnimation.values = @[value1, value2, value3, value4];
    
    //设置其他属性
    keyframeAnimation.duration = 8.0;
    keyframeAnimation.beginTime = CACurrentMediaTime() + 2;// 设置延迟2s
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"ADKeyframeAnimation_Position"];
}

// 贝瑟尔曲线动画
- (void)transitionCurveAnimation {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);// 移动到起点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 65, 600);// 绘制二次贝瑟尔曲线
    
    keyframeAnimation.path = path;
    keyframeAnimation.keyTimes = @[@0, @0.35, @0.65, @1];
    CGPathRelease(path);
    
    keyframeAnimation.duration = 8;
    keyframeAnimation.beginTime = CACurrentMediaTime() + 2;
    
    [_layer addAnimation:keyframeAnimation forKey:@"ADKeyframeAnimation_Position"];
}

@end
