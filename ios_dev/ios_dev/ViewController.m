//
//  ViewController.m
//  ios_dev
//
//  Created by 赖显波 on 8/20/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.doSomethingButton.hidden = YES;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSString *plainText = [NSString stringWithFormat:@"%@ button pressed.", title];
    //self.statusLabel.text = plainText;
    
    NSMutableAttributedString *styleText = [[NSMutableAttributedString alloc] initWithString:plainText];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:_statusLabel.font.pointSize]};
    
    NSRange nameRange = [plainText rangeOfString:title];
    
    [styleText setAttributes:attributes range:nameRange];
    self.statusLabel.attributedText = styleText;
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    long progress = lround(sender.value);
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld", progress];
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex ==  0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.doSomethingButton.hidden = YES;
    } else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.doSomethingButton.hidden = NO;
    }
}

- (IBAction)doSomthing:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?" delegate:self cancelButtonTitle:@"No Way!" destructiveButtonTitle:@"Yes, I'm Sure!" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (IBAction)switchChanged:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex != [actionSheet cancelButtonIndex]) {
        NSString *msg = nil;
        if([self.nameField.text length] > 0) {
            msg = [NSString stringWithFormat:@"You can breathe easy, %@, everything went OK.", self.nameField.text];
        } else {
            msg = @"You can breathe easy, everything went OK!";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something was done" message:msg delegate:nil cancelButtonTitle:@"Phew!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
