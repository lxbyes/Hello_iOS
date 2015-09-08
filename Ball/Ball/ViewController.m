//
//  ViewController.m
//  Ball
//
//  Created by 赖显波 on 9/7/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"
#import <CoreMotion/CoreMotion.h>

#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [(id)self.view setAcceleration:accelerometerData.acceleration];
        [self.view performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
    }];
}

@end
