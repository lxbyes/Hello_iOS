//
//  ViewController.m
//  AnimationDemo
//
//  Created by 赖显波 on 9/11/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "ADMainViewController.h"

@interface ADMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *opts;

@end

@implementation ADMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    self.opts = @[@"ADAnchorPointViewController",
                  @"ADDrawLayerViewController",
                  @"ADViewLayerViewController",
                  @"ADCoreAnimation1ViewController",
                  @"ADCoreAnimation2ViewController",
                  @"ADAnimationGroupViewController",
                  @"ADImageBrowserViewController",
                  @"ADScrollViewImageBrowserViewController",
                  @"ADDisplayLinkViewController",
                  @"ADParentViewController",
                  @"ADTransitionMain1ViewController",
                  @"ADCollectionViewController",
                  @"ADPingViewController"];
}

- (void)initViews {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark TableView DataSource and TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.opts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.opts[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.opts[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
