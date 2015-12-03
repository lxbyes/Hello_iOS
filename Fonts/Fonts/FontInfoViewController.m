//
//  FontInfoViewController.m
//  Fonts
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "FontInfoViewController.h"
#import "FavoritesList.h"

@interface FontInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fontSampleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;

@end

@implementation FontInfoViewController

- (void)viewDidLoad {
    self.fontSampleLabel.font = self.font;
    self.fontSampleLabel.text = @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklxcvbnm*#+-@$%^1234567890";
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f", self.font.pointSize];
    self.fontSizeSlider.value = self.font.pointSize;
    self.favoriteSwitch.on = self.favorite;
}

- (IBAction)sliderFontSize:(UISlider *)slider {
    float newSize = roundf(slider.value);
    self.fontSampleLabel.font = [self.font fontWithSize:newSize];
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f", newSize];
}

- (IBAction)toggleFavorite:(UISwitch *)sender {
    FavoritesList *favoritesList = [FavoritesList sharedFavoritesList];
    if(sender.on) {
        [favoritesList addFavorite:self.font.fontName];
    } else {
        [favoritesList removeFavorite:self.font.fontName ];
    }
}

@end
