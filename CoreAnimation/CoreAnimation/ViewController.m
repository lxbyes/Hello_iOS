//
//  ViewController.m
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#import "ClockFaceViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *airPlane;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"position.x";
    animation.fromValue = @60;
    animation.toValue = @455;
    animation.duration = 1.5;
    
    //animation.fillMode = kCAFillModeForwards;
    //animation.removedOnCompletion = NO;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.airPlane.layer addAnimation:animation forKey:@"some"];
    
    //self.airPlane.layer.position = CGPointMake(self.airPlane.layer.position.x + 10, self.airPlane.layer.position.y);
    //self.airPlane.center = CGPointMake(self.airPlane.layer.position.x + 10, self.airPlane.layer.position.y);
}

- (IBAction)startKeypath:(UIButton *)sender {
    CGRect boundingRect = CGRectMake(20, 20, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4.0;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [self.airPlane.layer addAnimation:orbit forKey:@"orbit"];
}

@end
