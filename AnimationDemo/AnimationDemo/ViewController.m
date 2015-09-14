//
//  ViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 9/11/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#import "LandscapeViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSArray *opts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.opts = @[@"Landscape"];
}

#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.opts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    
    cell.textLabel.text = self.opts[indexPath.row];
    
    return cell;
}

#pragma mark TableView Delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LandscapeViewController *landscapeViewController = [[LandscapeViewController alloc] init];
    [self presentViewController:landscapeViewController animated:YES completion:nil];
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue");
}

@end
