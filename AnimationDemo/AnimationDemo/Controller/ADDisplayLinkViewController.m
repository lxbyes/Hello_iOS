//
//  ADDisplayLinkViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/23.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import "ADDisplayLinkViewController.h"

@interface ADDisplayLinkViewController ()

@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ADDisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set background
    self.view.layer.contents = (id)[UIImage imageNamed:@"bg.jpg"].CGImage;
    
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, 87, 32);
    _layer.position = CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    
    //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
    //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
    _images = [NSMutableArray array];
    for (NSUInteger i = 0; i < 10; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"fish%@.png", @(i)];
        UIImage *image = [UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    //定义时钟对象
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //添加时钟对象到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)step {
    static int count = 0;
    if (++ count % 10 == 0) {
        UIImage *image = _images[_index];
        _layer.contents = (id)image.CGImage;
        _index = (_index + 1) % 10;
    }
}

@end
