//
//  ViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "PositionViewController.h"

@interface PositionViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueSpuare;

@property (weak, nonatomic) IBOutlet UIView *viewA;
@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UIView *viewC;

@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:1.0 animations:^{
        self.blueSpuare.center = CGPointMake(self.view.bounds.size.width - self.blueSpuare.center.x, self.blueSpuare.center.y );
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.blueSpuare.center = CGPointMake(self.view.bounds.size.width - self.blueSpuare.center.x, self.blueSpuare.center.y);
        }];
        
        // test bounds and frame
        [UIView animateWithDuration:1.5 animations:^{
            self.viewA.bounds = CGRectMake(self.viewB.frame.origin.x - 1, self.viewB.frame.origin.y - 1, self.viewA.bounds.size.width, self.viewA.bounds.size.height);
            self.viewB.bounds = CGRectMake(self.viewC.frame.origin.x - 1, self.viewC.frame.origin.y - 1, self.viewB.bounds.size.width, self.viewB.bounds.size.height);
        } completion:^(BOOL finished) {
            NSLog(@"A:");
            NSLog(@"x->bounds:%f, frame:%f", self.viewA.bounds.origin.x, self.viewA.frame.origin.x);
            NSLog(@"y->bounds:%f, frame:%f", self.viewA.bounds.origin.y, self.viewA.frame.origin.y);
            NSLog(@"w->bounds:%f, frame:%f", self.viewA.bounds.size.width, self.viewA.frame.size.width);
            NSLog(@"h->bounds:%f, frame:%f", self.viewA.bounds.size.height, self.viewA.frame.size.height);
            NSLog(@"B:");
            NSLog(@"x->bounds:%f, frame:%f", self.viewB.bounds.origin.x, self.viewB.frame.origin.x);
            NSLog(@"y->bounds:%f, frame:%f", self.viewB.bounds.origin.y, self.viewB.frame.origin.y);
            NSLog(@"w->bounds:%f, frame:%f", self.viewB.bounds.size.width, self.viewB.frame.size.width);
            NSLog(@"h->bounds:%f, frame:%f", self.viewB.bounds.size.height, self.viewB.frame.size.height);
            NSLog(@"C:");
            NSLog(@"x->bounds:%f, frame:%f", self.viewC.bounds.origin.x, self.viewC.frame.origin.x);
            NSLog(@"y->bounds:%f, frame:%f", self.viewC.bounds.origin.y, self.viewC.frame.origin.y);
            NSLog(@"w->bounds:%f, frame:%f", self.viewC.bounds.size.width, self.viewC.frame.size.width);
            NSLog(@"h->bounds:%f, frame:%f", self.viewC.bounds.size.height, self.viewC.frame.size.height);
        }];
    }];
}

@end
