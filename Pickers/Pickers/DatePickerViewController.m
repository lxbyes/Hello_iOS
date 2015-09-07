//
//  DatePickerViewController.m
//  Pickers
//
//  Created by 赖显波 on 8/25/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSDate *date = [self.datePicker date];
    NSString *message = [[NSString alloc] initWithFormat:@"The date and time you select is: %@", date];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date and Time Selected" message:message delegate:nil cancelButtonTitle:@"That's right" otherButtonTitles:nil, nil];
    [alert show];
}

@end
