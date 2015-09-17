//
//  ViewController.m
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#include "CustomTableVIewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger rowCount;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    rowCount = 10;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CourseCellIdentifier = @"customCell";
    CustomTableVIewCell *cell = (CustomTableVIewCell *)[tableView dequeueReusableCellWithIdentifier:CourseCellIdentifier forIndexPath:indexPath];
    cell.cellIndex = indexPath;
    cell.cellBlock = ^(BOOL isDelete, NSIndexPath *index) {
        if (isDelete) {
            [_mTableView beginUpdates];
            rowCount--;
            [_mTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            [_mTableView endUpdates];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_mTableView reloadData];
            });
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}
#pragma mark UITableViewDelegate

@end
