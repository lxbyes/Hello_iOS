//
//  DetailViewController.m
//  Presidents
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = modifyUrlForLanguage(newDetailItem, self.languageString);
            
        // Update the view.
        [self configureView];
    }
}

static NSString* modifyUrlForLanguage(NSString *url, NSString *lang) {
    if (!lang) {
        return url;
    }
    
    NSRange codeRange = NSMakeRange(7, 2);
    if([[url substringWithRange:codeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:codeRange withString:lang];
        return newUrl;
    }
}

- (void)configureView {
    NSURL *url = [NSURL URLWithString:self.detailItem];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lanuageButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleLanguagePopover)];
    self.navigationItem.rightBarButtonItem = self.lanuageButton;
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLanguageString:(NSString *)languageString {
    if (![languageString isEqualToString:self.languageString]) {
        _languageString = [languageString copy];
        self.detailItem = modifyUrlForLanguage(_detailItem, self.languageString);
    }
    if (self.languagePopoverController != nil) {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (void)toggleLanguagePopover {
    if (self.languagePopoverController == nil) {
        LanguageListController *languageListController = [[LanguageListController alloc] init];
        languageListController.detailViewController = self;
        
        UIPopoverController *poc = [[UIPopoverController alloc] initWithContentViewController:languageListController];
        
        [poc presentPopoverFromBarButtonItem:self.lanuageButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        self.languagePopoverController = poc;
    } else {
        if (self.languagePopoverController != nil) {
            [self.languagePopoverController dismissPopoverAnimated:YES];
            self.languagePopoverController = nil;
        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == self.languagePopoverController) {
        self.languagePopoverController = nil;
    }
}

@end
