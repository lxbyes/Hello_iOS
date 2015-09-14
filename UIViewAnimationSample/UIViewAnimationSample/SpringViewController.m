//
//  SpringViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "SpringViewController.h"

@interface SpringViewController ()

@property (strong, nonatomic) IBOutlet UIView *blueSqrare;
@property (strong, nonatomic) IBOutlet UIView *redSquare;
@property (strong, nonatomic) IBOutlet UIView *yellowSquar;
@property (strong, nonatomic) IBOutlet UIView *greenSquare;

@end

@implementation SpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.blueSqrare.center = CGPointMake(self.view.bounds.size.width - self.blueSqrare.center.x, self.blueSqrare.center.y);
    }];
    
    [UIView animateWithDuration:3.0 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:0 animations:^{
        self.redSquare.center = CGPointMake(self.view.bounds.size.width - self.redSquare.center.x, self.redSquare.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:3.0 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.8 options:0 animations:^{
        self.yellowSquar.center = CGPointMake(self.view.bounds.size.width - self.yellowSquar.center.x, self.yellowSquar.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:3.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:0 animations:^{
        self.greenSquare.center = CGPointMake(self.view.bounds.size.width - self.greenSquare.center.x, self.greenSquare.center.y);
    } completion:nil];
}
@end
