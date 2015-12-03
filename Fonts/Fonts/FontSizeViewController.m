//
//  FontSizeViewController.m
//  Fonts
//
//  Created by 赖显波 on 8/27/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "FontSizeViewController.h"

@implementation FontSizeViewController

- (NSArray *)pointSize {
    static NSArray *pointSizes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pointSizes = @[@9, @10, @11, @12, @13, @14, @18, @24, @36, @48, @64, @72, @96, @144];
    });
    
    return pointSizes;
}

- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *pointSize = [self pointSize][indexPath.row];
    return [self.font fontWithSize:pointSize.floatValue];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self pointSize] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FontNameAndSize";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-->*#+-0123", self.font.fontName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ point", [self pointSize][indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    
    return 25 + font.ascender - font.descender;
}

@end
