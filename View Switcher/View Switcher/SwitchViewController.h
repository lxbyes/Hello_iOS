//
//  SwitchViewController.h
//  View Switcher
//
//  Created by 赖显波 on 8/24/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowViewController.h"
#import "BlueViewController.h"

@interface SwitchViewController : UIViewController

@property (strong, nonatomic) YellowViewController *yellowViewController;

@property (strong, nonatomic) BlueViewController *blueViewController;

- (IBAction)switchViews:(id)sender;

@end
