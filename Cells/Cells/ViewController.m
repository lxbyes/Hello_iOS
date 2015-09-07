//
//  ViewController.m
//  Cells
//
//  Created by 赖显波 on 8/26/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ViewController.h"
#import "NameAndColorCell.h"

static NSString *CellTableIdentifier = @"CellTableIdentifier";
@interface ViewController ()

@property (copy, nonatomic) NSArray *computers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.computers = @[@{@"Name": @"MacBook Air", @"Color": @"Silver"}, @{@"Name": @"MacBook Pro", @"Color": @"Silver"}, @{@"Name": @"iMac", @"Color": @"Silver"}, @{@"Name": @"Mac Mini", @"Color": @"Silver"}, @{@"Name": @"Mac Pro", @"Color": @"Black"}, @{@"Name": @"MacBook Pro", @"Color": @"Black"}];
   
    UITableView *tableView = (id)[self.view viewWithTag:1];
    tableView.rowHeight = 65;
    UINib *nib = [UINib nibWithNibName:@"NameAndColorCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 20;
    [tableView setContentInset:contentInset];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.computers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NameAndColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    NSDictionary *rowData = self.computers[indexPath.row];
    
    cell.name = rowData[@"Name"];
    cell.color = rowData[@"Color"];
    
    return cell;
}
@end
