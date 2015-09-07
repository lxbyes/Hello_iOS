//
//  LanguageListController.h
//  Presidents
//
//  Created by 赖显波 on 8/28/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LanguageListController : UITableViewController

@property (weak, nonatomic) DetailViewController *detailViewController;

@property (copy, nonatomic) NSArray *languageNames;

@property (copy, nonatomic) NSArray *languageCodes;

@end
