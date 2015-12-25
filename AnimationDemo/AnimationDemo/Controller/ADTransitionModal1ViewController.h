//
//  ADTransitionModel1ViewController.h
//  AnimationDemo
//
//  Created by 赖显波 on 15/12/24.
//  Copyright © 2015年 Leckie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADTransitionModal1ViewController;
@protocol ModelViewControllerDelegate <NSObject>

- (void)modalViewControllerDidDismiss:(ADTransitionModal1ViewController *)viewController;

@end

@interface ADTransitionModal1ViewController : UIViewController

@property (nonatomic, weak) id<ModelViewControllerDelegate> delegate;

@end
