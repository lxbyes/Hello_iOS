//
//  OptionTableViewCell.m
//  CustomTable
//
//  Created by 赖显波 on 9/17/15.
//  Copyright © 2015 Leckie. All rights reserved.
//

#import "OptionTableViewCell.h"

@interface OptionTableViewCell () <UIGestureRecognizerDelegate>
{
    CGPoint _lastPoint;
}
@end

@implementation OptionTableViewCell

- (void)awakeFromNib {
    UIPanGestureRecognizer *swipeLeft = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.delegate = self;
    [self.containerView addGestureRecognizer:swipeLeft];
}

- (void)swipeLeft:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self.contentView];
    CGFloat cx = self.containerView.center.x + point.x;
    if (cx >= self.contentView.center.x - self.deleteButton.frame.size.width - self.markButton.frame.size.width && cx <= self.contentView.center.x) {
        self.containerView.center = CGPointMake(cx, self.containerView.center.y);
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.containerView.frame.origin.x < -30) {
            [self hideButtons];
        } else {
            [self showButtons];
        }
    }
    
    [gesture setTranslation:CGPointZero inView:self.contentView];
}

- (void)showButtons {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.center = self.contentView.center;
    }];
}

- (void)hideButtons {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.center = CGPointMake(self.contentView.center.x - (self.deleteButton.frame.size.width + self.markButton.frame.size.width), self.contentView.center.y);
    }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}

@end
