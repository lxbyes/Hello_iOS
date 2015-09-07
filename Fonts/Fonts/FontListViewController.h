//
//  FontListViewController.h
//  Fonts
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListViewController : UITableViewController

@property (copy, nonatomic) NSArray *fontNames;

@property (assign, nonatomic) BOOL showsFavorites;

@end
