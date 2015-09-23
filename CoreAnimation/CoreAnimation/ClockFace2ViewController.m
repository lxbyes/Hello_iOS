//
//  ClockFace2ViewController.m
//  CoreAnimation
//
//  Created by 赖显波 on 9/18/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "ClockFace2ViewController.h"
#import "ClockFace2.h"

@interface ClockFace2ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) ClockFace2 *clockFace;

@end

@implementation ClockFace2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.clockFace = [[ClockFace2 alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.view.layer addSublayer:self.clockFace];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.clockFace.time = [textField.text floatValue];
}


@end
