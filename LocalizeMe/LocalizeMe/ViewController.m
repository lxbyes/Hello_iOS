//
//  ViewController.m
//  LocalizeMe
//
//  Created by 赖显波 on 9/8/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *localeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Localize
    NSLocale *locale = [NSLocale currentLocale];
    NSString *currentLangID = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSString *displayLang = [locale displayNameForKey:NSLocaleLanguageCode value:currentLangID];
    NSString *capitalized = [displayLang capitalizedStringWithLocale:locale];
    self.localeLabel.text = capitalized;
    
    [self.labels[0] setText:NSLocalizedString(@"LABEL_ONE", @"1")];
    [self.labels[1] setText:NSLocalizedString(@"LABEL_TWO", @"2")];
    [self.labels[2] setText:NSLocalizedString(@"LABEL_THREE", @"3")];
    [self.labels[3] setText:NSLocalizedString(@"LABEL_FOUR", @"4")];
    [self.labels[4] setText:NSLocalizedString(@"LABEL_FIVE", @"5")];
      
    NSString *flagFile = NSLocalizedString(@"FLAG_FILE", @"Name of the flag");
    self.flagImageView.image = [UIImage imageNamed:flagFile];
}

@end
