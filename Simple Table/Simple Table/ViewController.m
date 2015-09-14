//
//  ViewController.m
//  Simple Table
//
//  Created by 赖显波 on 8/25/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (copy, nonatomic) NSArray *dwarves;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dwarves = @[@"Sleepy", @"Sneezy", @"Bashful", @"Happy", @"Doc", @"Grumpy", @"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur"];
   /* UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    [tableView setContentInset:contentInset];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dwarves count];
}

#pragma mark UITableView DataSource Methods

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    
    UIImage *imageLike = [UIImage imageNamed:@"iconfont-like"];
    UIImage *imageMy = [UIImage imageNamed:@"iconfont-my"];
    cell.imageView.image = imageLike;
    cell.imageView.highlightedImage = imageMy;
    
    cell.textLabel.text = self.dwarves[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:30]; // 更改字体
    
    if(indexPath.row < 7) {
        cell.detailTextLabel.text = @"Mr. Disney";
    } else {
        cell.detailTextLabel.text = @"Mr. Tolkien";
    }
    return cell;
}

#pragma mark UITableView Delegate Methods

// 设置缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row % 8;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rowValue = self.dwarves[indexPath.row];
    
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@", rowValue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end
