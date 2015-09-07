//
//  ViewController.h
//  ios_dev
//
//  Created by 赖显波 on 8/20/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;

- (IBAction)switchChanged:(UISwitch *)sender;

- (IBAction)buttonPressed:(UIButton *)sender;

- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)sliderChanged:(UISlider *)sender;

- (IBAction)toggleControls:(UISegmentedControl *)sender;

- (IBAction)doSomthing:(id)sender;

@end

