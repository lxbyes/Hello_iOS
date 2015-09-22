//
//  ViewController.m
//  LeftMenu
//
//  Created by 赖显波 on 9/22/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "LMRootViewController.h"

@interface LMRootViewController ()

@end

@implementation LMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)awakeFromNib {
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    self.rightMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rightMenuViewController"];
    
    self.scaleContentView = NO;
    self.scaleMenuView = NO;
    self.contentViewShadowEnabled = YES;
}

@end
