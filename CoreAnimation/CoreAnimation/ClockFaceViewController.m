//
//  ClockFaceViewController.m
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "ClockFaceViewController.h"

@interface ClockFaceViewController ()

@end

@implementation ClockFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clockFace = [[ClockFace alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.view.layer addSublayer:self.clockFace];
    
    self.clockFace.time = [NSDate date];
}

- (IBAction)setTime:(UIDatePicker *)sender {
    self.clockFace.time = sender.date;
}

@end
