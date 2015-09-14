//
//  ColorViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueSquare;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:3.0 animations:^{
        self.blueSquare.backgroundColor = [UIColor purpleColor];
        self.label.textColor = [UIColor grayColor];
    }];
}
@end
