//
//  CustomTableVIewCell.h
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^handleGestureEnderBlock)(BOOL idDelete, NSIndexPath *index);

@interface CustomTableVIewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) NSIndexPath *cellIndex;
@property (copy, nonatomic) handleGestureEnderBlock cellBlock;

@end
