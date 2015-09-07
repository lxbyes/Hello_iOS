//
//  YellowViewController.m
//  View Switcher
//
//  Created by 赖显波 on 8/24/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "YellowViewController.h"

@interface YellowViewController ()

@end

@implementation YellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)yellowButtonPressed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yellow Button Pressed" message:@"You clicked the yellow Button." delegate:nil cancelButtonTitle:@"Yep, I did." otherButtonTitles:nil, nil];
    [alert show];
}

@end
