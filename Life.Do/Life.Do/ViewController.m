//
//  ViewController.m
//  Life.Do
//
//  Created by 赖显波 on 9/9/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSUInteger _currentColorIndex;
    NSArray *_colors;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _currentColorIndex = 0;
    _colors = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor grayColor], [UIColor purpleColor], [UIColor brownColor]];
}

- (IBAction)toggleTheme:(UIButton *)sender {
    _currentColorIndex = (++_currentColorIndex) % [_colors count];
    [self.view setBackgroundColor:_colors[_currentColorIndex]];
}

@end
