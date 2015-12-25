//
//  CAImageBrowserViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADImageBrowserViewController.h"

@interface ADImageBrowserViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation ADImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"0.jpg"];
    [self.view addSubview:_imageView];
    
    // add gesture
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

- (void)leftSwipe:(UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:YES];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture {
    [self transitionAnimation:NO];
}

-(void)transitionAnimation:(BOOL)isNext {
    //1.创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type = @"cameralIrisHollowOpen";
    //设置子类型
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    
    transition.duration = 1.0;
    //3.设置转场后的新视图添加转场动画
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"ADTransitionAnimation"];
}

- (UIImage *)getImage:(BOOL)isNext {
    if (isNext) {
        _currentIndex = (_currentIndex + 1) % 5;
    } else {
        _currentIndex = (_currentIndex + 5 - 1) % 5;
    }
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", @(_currentIndex)]];
    return image;
}
@end
