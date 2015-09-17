//
//  CustomTableVIewCell.m
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright (c) 2015 Leckie. All rights reserved.
//

#import "CustomTableVIewCell.h"

@interface CustomTableVIewCell ()
{
    UIView *snapView;
    CGPoint startPoint;
    CGFloat x;
    CGFloat y;
}
@end

@implementation CustomTableVIewCell

- (void)awakeFromNib {
    _containerView.layer.cornerRadius = 4;
    
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressRecognizer:)];
    [self.contentView addGestureRecognizer:longPress];
    
}

- (void)handleLongpressRecognizer:(UILongPressGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            snapView = [_containerView snapshotViewAfterScreenUpdates:NO];
            startPoint = [gesture locationInView:self.contentView];
            x = snapView.center.x - startPoint.x;
            y = snapView.center.y - startPoint.y;
            
            snapView.frame = _containerView.frame;
            snapView.transform = CGAffineTransformMakeRotation(M_PI / 30);
      
            [self.contentView addSubview:snapView];
            self.containerView.hidden = YES;
            self.shadowView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [gesture locationInView:self.contentView];
            snapView.center = CGPointMake(changePoint.x + x, snapView.center.y);
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGPoint endPoint = [gesture locationInView:self.contentView];
            if (endPoint.x > startPoint.x + 100) {
                if (self.cellBlock) {
                    self.cellBlock(YES, _cellIndex);
                }
            } else {
                if (self.cellBlock) {
                    self.cellBlock(NO, _cellIndex);
                }
            }
            [snapView removeFromSuperview];
            self.containerView.hidden = NO;
            self.shadowView.hidden = NO;
            break;
        }
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
