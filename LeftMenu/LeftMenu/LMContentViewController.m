//
//  ContentViewController.m
//  LeftMenu
//
//  Created by 赖显波 on 9/22/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "LMContentViewController.h"
#import "LMRootViewController.h"

@interface LMContentViewController ()

@end

@implementation LMContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showLeftMenu:(UIBarButtonItem *)sender {
    [self presentLeftMenuViewController:sender];
}

- (IBAction)showRightMenu:(UIBarButtonItem *)sender {
    [self presentRightMenuViewController:sender];
}

@end
