//
//  OptionTableViewCell.h
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *markButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end
