//
//  LoginViewController.m
//  UIViewAnimationSample
//
//  Created by 赖显波 on 9/13/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *buddle1;
@property (weak, nonatomic) IBOutlet UIImageView *buddle2;
@property (weak, nonatomic) IBOutlet UIImageView *buddle3;
@property (weak, nonatomic) IBOutlet UIImageView *buddle4;
@property (weak, nonatomic) IBOutlet UIImageView *buddle5;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *dot;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;

@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) CGPoint lastPosition;

@property (strong, nonatomic) UIImageView *warningImageView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buddle1.transform = CGAffineTransformMakeScale(0, 0);
    self.buddle2.transform = CGAffineTransformMakeScale(0, 0);
    self.buddle3.transform = CGAffineTransformMakeScale(0, 0);
    self.buddle4.transform = CGAffineTransformMakeScale(0, 0);
    self.buddle5.transform = CGAffineTransformMakeScale(0, 0);
    
    self.logo.center = CGPointMake(-self.logo.bounds.size.width, self.logo.center.y);
    self.dot.center = CGPointMake(self.dot.center.x - 50, -self.dot.center.y);
    
    UIView *usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, self.username.frame.size.height)];
    self.username.leftView = usernameLeftView;
    self.username.leftViewMode = UITextFieldViewModeAlways;

    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, self.password.frame.size.height)];
    self.password.leftView = passwordLeftView;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *usernameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User"]];
    usernameImageView.frame = CGRectMake(13, 10, usernameImageView.frame.size.width, usernameImageView.frame.size.height);
    [self.username addSubview:usernameImageView];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Key"]];
    passwordImageView.frame = CGRectMake(13, 10, passwordImageView.frame.size.width, passwordImageView.frame.size.height);
    [self.password addSubview:passwordImageView];
    
    self.username.center = CGPointMake(self.username.center.x - self.view.bounds.size.width, self.username.center.y);
    self.password.center = CGPointMake(self.password.center.x - self.view.bounds.size.width, self.password.center.y);
    
    self.login.center = CGPointMake(self.login.center.x - self.view.bounds.size.width, self.login.center.y);
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(48, 24);
    
    self.warningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Warning"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
        self.buddle1.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.buddle4.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
        self.buddle3.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];

    [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
        self.buddle2.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.buddle5.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:0 animations:^{
        self.logo.center = CGPointMake(self.view.bounds.size.width / 2, self.logo.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:3 delay:0.3 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        self.dot.center = CGPointMake(self.dot.center.x + 50, -self.dot.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.username.center = CGPointMake(self.username.center.x + self.view.bounds.size.width, self.username.center.y);
    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.password.center = CGPointMake(self.password.center.x + self.view.bounds.size.width, self.password.center.y);
    } completion:nil];

    [UIView animateWithDuration:0.4 delay:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.login.center = CGPointMake(self.login.center.x + self.view.bounds.size.width, self.login.center.y);
    } completion:^(BOOL finished) {
        self.lastPosition = self.login.center;
        [self.view addSubview:self.warningImageView];
        self.warningImageView.frame = self.login.frame;
        self.warningImageView.hidden = YES;
    }];
}

- (IBAction)login:(UIButton *)sender {
    [self.login addSubview:self.spinner];
    [self.spinner startAnimating];
    
    [UIView transitionWithView:self.warningImageView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromBottom | UIViewAnimationOptionCurveEaseIn animations:^{
        self.warningImageView.hidden = YES;
    } completion:nil];
    
    self.login.center = self.lastPosition;
    self.login.center = CGPointMake(self.login.center.x - 30, self.login.center.y);
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        self.login.center = CGPointMake(self.login.center.x + 30, self.login.center.y);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.login.center = CGPointMake(self.login.center.x, self.login.center.y + 80);
            [self.spinner removeFromSuperview];
        } completion:^(BOOL finished) {
            [UIView transitionWithView:self.warningImageView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromTop | UIViewAnimationOptionCurveEaseOut animations:^{
                self.warningImageView.hidden = NO;
            } completion:nil];
        }];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
