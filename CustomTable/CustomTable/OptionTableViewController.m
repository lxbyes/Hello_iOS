//
//  OptionTableViewController.m
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "OptionTableViewController.h"
#import "OptionTableViewCell.h"

@interface OptionTableViewController ()
{
    NSInteger rowCount;
}
@end

@implementation OptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    rowCount = 20;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *OptionTableViewCellIdentifier = @"OptionCellIdentifier";
    OptionTableViewCell *cell = (OptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:OptionTableViewCellIdentifier];
    //[cell.deleteButton addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
    cell.message.text = [NSString stringWithFormat:@"Message %ld", indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
